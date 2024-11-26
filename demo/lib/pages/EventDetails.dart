import 'package:flutter/material.dart';
import 'QRCodeScreen.dart';

class EventDetails extends StatelessWidget {
  final Map<String, String> event;

  EventDetails({required this.event});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(event['name']!),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(event['description']!),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => QRCodeScreen(event: event)),
                );
              },
              child: Text('Registrar Asistencia'),
            ),
          ],
        ),
      ),
    );
  }
}
