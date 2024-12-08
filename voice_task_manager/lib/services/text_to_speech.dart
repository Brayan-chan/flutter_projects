import 'package:flutter_tts/flutter_tts.dart';

class TextToSpeech {
  final FlutterTts _tts = FlutterTts();

  Future<void> speak(String text) async {
    await _tts.setLanguage("es-ES"); // Cambia a tu idioma preferido
    await _tts.setPitch(1.0);
    await _tts.setSpeechRate(0.9);
    await _tts.speak(text);
  }
}
