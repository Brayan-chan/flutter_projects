import 'package:flutter/material.dart';
import '../services/voice_recognizer.dart';
import '../services/text_to_speech.dart';
import '../services/database_service.dart';

class VoiceCommandScreen extends StatefulWidget {
  @override
  _VoiceCommandScreenState createState() => _VoiceCommandScreenState();
}

class _VoiceCommandScreenState extends State<VoiceCommandScreen> {
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

  Future<void> _handleCommand() async {
    String? command = await _voiceRecognizer.listen();
    if (command != null) {
      setState(() {
        _result = command;
      });

      // Ejemplo: "¿Qué tareas debo realizar a las 7?"
      if (command.contains('tareas')) {
        String hourString = command.split('a las').last.trim();
        int hour = int.tryParse(hourString.split(':').first) ?? 0;

        final tasks = await DatabaseService().getTasksAtTime(
          DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day, hour),
        );

        if (tasks.isNotEmpty) {
          String response = tasks.map((t) => t.description).join(', ');
          await _textToSpeech.speak('Tus tareas son: $response');
        } else {
          await _textToSpeech.speak('No tienes tareas programadas a esa hora.');
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Comando de Voz')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Resultado: $_result'),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: _handleCommand,
              child: Text('Escuchar Comando'),
            ),
          ],
        ),
      ),
    );
  }
}
