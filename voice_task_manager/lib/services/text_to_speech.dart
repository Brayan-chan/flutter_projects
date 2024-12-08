import 'package:flutter_tts/flutter_tts.dart';

class TextToSpeech {
  final FlutterTts _tts = FlutterTts();

  Future<void> speak(String text) async {
    await _tts.setLanguage('es-ES');
    await _tts.setPitch(1.0);
    await _tts.speak(text);
  }
}
