import 'package:flutter/material.dart';
import 'screens/add_task_screen.dart';
import 'screens/home_screen.dart';
import 'screens/voice_command_screen.dart';
import 'services/foreground_service.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Inicializa el servicio en segundo plano
  final ForegroundService foregroundService = ForegroundService();
  await foregroundService.startService();

  // Manejo de errores de Flutter
  FlutterError.onError = (FlutterErrorDetails details) {
    FlutterError.presentError(details);
  };

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Recordatorios',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => HomeScreen(),
        '/add_task': (context) => AddTaskScreen(),
        '/voice_command': (context) => VoiceCommandScreen(),
      },
    );
  }
}