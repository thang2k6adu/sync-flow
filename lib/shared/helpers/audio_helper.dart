import 'package:record/record.dart';
import 'package:path_provider/path_provider.dart';

class AudioHelper {
  final audioRecorder = AudioRecorder();

  Future<String?> startRecording({String? fileName}) async {
    if (!await audioRecorder.hasPermission()) return null;

    final tempDir = await getTemporaryDirectory();
    final path =
      '${tempDir.path}/${fileName ?? DateTime.now().millisecondsSinceEpoch}.m4a';

    await audioRecorder.start(const RecordConfig(), path: path);
    return path;
  }

  Future<String?> stopRecording() async {
    return await audioRecorder.stop();
  }
}
