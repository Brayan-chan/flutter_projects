import 'package:speech_to_text/speech_to_text.dart';

class VoiceRecognizer {
  final SpeechToText _speech = SpeechToText();

  Future<void> initialize() async {
    bool available = await _speech.initialize();
    if (!available) throw 'Speech Recognition not available';
  }

  Future<String?> listen() async {
    String? result;
    _speech.listen(
      onResult: (val) {
        result = val.recognizedWords;
      },
    );
    await Future.delayed(Duration(seconds: 5));
    _speech.stop();
    return result;
  }
}