import 'package:flutter/material.dart';
import 'screens/home_screen.dart';
import 'screens/add_task_screen.dart';
import 'screens/voice_command_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  const MyApp({super.key});  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Voice Task Manager',
      theme: ThemeData(primarySwatch: Colors.blue),
      initialRoute: '/',
      routes: {
        '/': (context) => HomeScreen(),
        '/add_task': (context) => AddTaskScreen(),
        '/voice_command': (context) => VoiceCommandScreen(),
      },
    );
  }
}
