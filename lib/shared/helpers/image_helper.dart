import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image/image.dart' as img;
import 'package:path_provider/path_provider.dart';

class ImageHelper {
  ImageHelper({
    ImagePicker? imagePicker,
    ImageCropper? imageCropper,
  })  : _imagePicker = imagePicker ?? ImagePicker(),
        _imageCropper = imageCropper ?? ImageCropper();

  final ImagePicker _imagePicker;
  final ImageCropper _imageCropper;

  Future<XFile> resizeImageIfNeeded(XFile file) async {
    const maxDimension = 1280;
    const maxFileSizeBytes = 2 * 1024 * 1024; // 1MB

    final originalFile = File(file.path);
    final bytes = await originalFile.readAsBytes();

    // Check file size
    if (bytes.lengthInBytes <= maxFileSizeBytes) {
      // Check the length, read Metadata
      final image = img.decodeImage(bytes);
      if (image == null) return file;

      if (image.width <= maxDimension && image.height <= maxDimension) {
        // No need to resize
        return file;
      }
    }
    // Large 2MB file -> resize

    // Decoding photos
    final image = img.decodeImage(bytes);
    if (image == null) return file;
    // Calculate the rate of resize retains the ratio
    int newWidth = image.width;
    int newHeight = image.height;
    if (image.width > image.height) {
      if (image.width > maxDimension) {
        newWidth = maxDimension;
        newHeight = (image.height * maxDimension / image.width).round();
      }
    } else {
      if (image.height > maxDimension) {
        newHeight = maxDimension;
        newWidth = (image.width * maxDimension / image.height).round();
      }
    }

    final resizedImage =
        img.copyResize(image, width: newWidth, height: newHeight);

    // Compress images into 80% JPG
    final jpgBytes = img.encodeJpg(resizedImage, quality: 80);

    // Save the temporary file
    final tempDir = await getTemporaryDirectory();
    final resizedFilePath =
        '${tempDir.path}/${DateTime.now().millisecondsSinceEpoch}.jpg';
    final resizedFile = File(resizedFilePath);
    await resizedFile.writeAsBytes(jpgBytes);

    return XFile(resizedFile.path);
  }

  Future<List<XFile>> pickImages({
    ImageSource source = ImageSource.gallery,
    int imageQuality = 100,
    int limit = 10,
    bool multiple = false,
  }) async {
    FocusManager.instance.primaryFocus?.unfocus();

    List<XFile> pickedFiles = [];

    if (multiple) {
      pickedFiles = await _imagePicker.pickMultiImage(
        imageQuality: imageQuality,
        limit: limit,
      );
    } else {
      final file = await _imagePicker.pickImage(
        source: source,
        imageQuality: imageQuality,
      );
      if (file != null) pickedFiles = [file];
    }

    if (pickedFiles.isEmpty) return [];

    List<XFile> resultFiles = [];
    for (XFile file in pickedFiles) {
      XFile resizedFile = await resizeImageIfNeeded(file);
      resultFiles.add(resizedFile);
    }

    return resultFiles;
  }

  Future<XFile?> cropImages(
      {required XFile file,
      CropStyle cropStyle = CropStyle.rectangle,
      CropAspectRatio? cropAspectRatio}) async {
    FocusManager.instance.primaryFocus?.unfocus();
    final croppedFile = await _imageCropper.cropImage(
        sourcePath: file.path,
        compressQuality: 80,
        aspectRatio: cropAspectRatio,
        uiSettings: [
          AndroidUiSettings(
              toolbarTitle: 'Cropper',
              toolbarColor: Colors.deepOrange,
              toolbarWidgetColor: Colors.white,
              lockAspectRatio: true,
              hideBottomControls: true,
              cropStyle: cropStyle),
          IOSUiSettings(
            title: 'Cropper',
            cropStyle: cropStyle,
            aspectRatioLockEnabled: true,
            aspectRatioPickerButtonHidden: true,
          )
        ]);
    if (croppedFile == null) {
      return null;
    }

    final xFile = XFile(croppedFile.path,
        mimeType: 'image/png',
        name: croppedFile.path.split('/').last,
        bytes: await croppedFile.readAsBytes());

    return await resizeImageIfNeeded(xFile);
  }
}
