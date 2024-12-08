import 'package:flutter/material.dart';
import '../services/voice_recognizer.dart';
import '../services/text_to_speech.dart';
import '../services/database_service.dart';

class VoiceCommandScreen extends StatefulWidget {
  const VoiceCommandScreen({super.key});

  @override
  VoiceCommandScreenState createState() => VoiceCommandScreenState();
}

class VoiceCommandScreenState extends State<VoiceCommandScreen> {
  final _voiceRecognizer = VoiceRecognizer();
  final _textToSpeech = TextToSpeech();
  String _result = '';

  @override
  void initState() {
    super.initState();
    _initializeVoiceRecognizer();
  }

  Future<void> _initializeVoiceRecognizer() async {
    await _voiceRecognizer.initialize();
  }

  Future<void> _handleVoiceCommand() async {
    String? command = await _voiceRecognizer.listen();
    if (command != null) {
      setState(() {
        _result = command;
      });

      if (command.contains('tareas')) {
        final now = DateTime.now();
        final tasks = await DatabaseService().getTasksAtTime(now);

        if (tasks.isNotEmpty) {
          String response = tasks.map((t) => t.description).join(', ');
          await _textToSpeech.speak('Tus tareas son: $response');
        } else {
          await _textToSpeech.speak('No tienes tareas programadas en este momento.');
        }
      } else {
        await _textToSpeech.speak('No entendí tu comando. Intenta de nuevo.');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Comandos de Voz')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Comando: $_result'),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: _handleVoiceCommand,
              child: Text('Escuchar Comando'),
            ),
          ],
        ),
      ),
    );
  }
}
