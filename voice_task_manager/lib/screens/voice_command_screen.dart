import 'package:flutter/material.dart';
import '../services/foreground_service.dart';

class VoiceCommandScreen extends StatefulWidget {
  @override
  _VoiceCommandScreenState createState() => _VoiceCommandScreenState();
}

class _VoiceCommandScreenState extends State<VoiceCommandScreen> {
  @override
  void initState() {
    super.initState();

    // Inicia el servicio en segundo plano
    final ForegroundService foregroundService = ForegroundService();
    foregroundService.startService();

    // Inicializa el reconocimiento de voz
    _initializeVoiceRecognition();
  }

  void _initializeVoiceRecognition() {
    // Configuración del reconocimiento de voz
    // Ejemplo: SpeechRecognizer, configuración de eventos, etc.
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Comandos por Voz'),
      ),
      body: Center(
        child: Text('Diga un comando por voz...'),
      ),
    );
  }
}
