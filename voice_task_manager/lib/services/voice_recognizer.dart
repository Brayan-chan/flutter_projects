import 'package:speech_to_text/speech_to_text.dart' as stt;

class VoiceRecognizer {
  final stt.SpeechToText _speech = stt.SpeechToText();

  Future<bool> initialize() async {
    bool available = await _speech.initialize(
      onStatus: (status) => print('onStatus: $status'),
      onError: (error) => print('onError: $error'),
    );
    if (!available) {
      print('Reconocimiento de voz no disponible');
    }
    return available;
  }

  Future<String?> listenForCommand() async {
    if (!_speech.isAvailable) {
      print('Reconocimiento de voz no disponible');
      return null;
    }

    String? recognizedWords;
    _speech.listen(
      onResult: (result) {
        if (result.hasConfidenceRating && result.confidence > 0) {
          recognizedWords = result.recognizedWords;
          _speech.stop(); // Detiene la escucha después del primer comando
        }
      },
      listenFor: Duration(seconds: 5), // Escuchar por 5 segundos
      pauseFor: Duration(seconds: 5), // Pausar por 5 segundos
      partialResults: false, // No devolver resultados parciales
      localeId: 'es_ES', // Asegúrate de usar el locale correcto
    );

    await Future.delayed(const Duration(seconds: 5));
    _speech.stop();
    return recognizedWords; // Devuelve las palabras reconocidas o null si no se captó nada
  }
}