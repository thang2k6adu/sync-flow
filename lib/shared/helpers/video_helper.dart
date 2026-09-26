import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class VideoHelper {
  VideoHelper({ImagePicker? imagePicker})
      : _imagePicker = imagePicker ?? ImagePicker();

  final ImagePicker _imagePicker;

  /// Pick video from gallery (without compression)
  Future<XFile?> pickVideo({
    ImageSource source = ImageSource.gallery,
    int maxDurationSeconds = 300,
  }) async {
    FocusManager.instance.primaryFocus?.unfocus();

    final XFile? videoFile = await _imagePicker.pickVideo(
      source: source,
      maxDuration: Duration(seconds: maxDurationSeconds),
    );

    return videoFile;
  }
}