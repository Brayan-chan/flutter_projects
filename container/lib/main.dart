import 'package:container/pages/ContainerOne.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
       debugShowCheckedModeBanner: false,
        home: const ContainerOne(),
        //Creando las rutas a las que podemos navegar
        routes: {
          '/containerone' : (context) => const ContainerOne(),
        }
    ); 
  }
}
