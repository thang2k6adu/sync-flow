import 'package:audioplayers/audioplayers.dart';
import 'package:flutter_tts/flutter_tts.dart';

class TtsService {
  final FlutterTts _flutterTts = FlutterTts();
  final AudioPlayer _audioPlayer = AudioPlayer();
  bool _isInitialized = false;

  TtsService() {
    _initTts();
  }

  Future<void> _initTts() async {
    try {
      await _flutterTts.setLanguage('en-US');
      await _flutterTts.setSpeechRate(0.45);
      await _flutterTts.setVolume(1.0);
      await _flutterTts.setPitch(1.0);
      _isInitialized = true;
    } catch (_) {
      // Fallback: system will use default settings
    }
  }

  /// Phát âm thanh:
  /// Nếu có [audioUrl] hợp lệ -> ưu tiên phát file mp3/audio.
  /// Nếu không có [audioUrl] -> tự động đọc [text] bằng Text-To-Speech giọng chuẩn Anh - Mỹ.
  Future<void> speak({
    required String text,
    String? audioUrl,
  }) async {
    try {
      await stop();

      if (audioUrl != null && audioUrl.trim().isNotEmpty) {
        try {
          await _audioPlayer.play(UrlSource(audioUrl.trim()));
          return;
        } catch (_) {
          // Nếu link audio lỗi, fallback sang TTS giọng máy
        }
      }

      if (text.trim().isNotEmpty) {
        if (!_isInitialized) {
          await _initTts();
        }
        await _flutterTts.speak(text.trim());
      }
    } catch (e) {
      // Silent catch or log to prevent UI crash
    }
  }

  Future<void> stop() async {
    try {
      await _flutterTts.stop();
      await _audioPlayer.stop();
    } catch (_) {}
  }
}
