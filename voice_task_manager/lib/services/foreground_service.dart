import 'package:flutter_foreground_task/flutter_foreground_task.dart';

class ForegroundService {
  Future<void> startService() async {
    await FlutterForegroundTask.startService(
      notificationTitle: 'App de recordatorios',
      notificationText: 'Escuchando comandos por voz...',
    );
  }

  Future<void> stopService() async {
    await FlutterForegroundTask.stopService();
  }
}