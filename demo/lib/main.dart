import 'package:demo/pages/Dashboard.dart';
import 'package:demo/pages/SignInScreen.dart';
import 'package:demo/pages/SignUpScreen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Event App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: SignInScreen(),
      routes: {
        '/signup': (context) => SignUpScreen(),
        '/dashboard': (context) => Dashboard(),
        '/qr_code_screen': (context) => QRCodeScreen(event: { 'name': 'Evento 1', 'description': 'Descripción del evento 1'}),
      },
    );
  }
}