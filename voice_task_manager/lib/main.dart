import 'package:flutter/material.dart';
import 'screens/add_task_screen.dart';
import 'screens/home_screen.dart';
import 'screens/voice_command_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  FlutterError.onError = (FlutterErrorDetails details) {
    FlutterError.presentError(details);
    // Aquí podrías agregar registro de errores a un servicio externo como Firebase Crashlytics.
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