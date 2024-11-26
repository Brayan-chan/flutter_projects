import 'package:demo/pages/EventDetails.dart';
import 'package:flutter/material.dart';
import 'QRCodeScreen.dart';

class Dashboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List<Map<String, String>> events = [
      {'name': 'Evento 1', 'description': 'Descripción del evento 1'},
      {'name': 'Evento 2', 'description': 'Descripción del evento 2'},
      {'name': 'Evento 3', 'description': 'Descripción del evento 3'},
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text('Dashboard'),
      ),
      body: ListView.builder(
        itemCount: events.length,
        itemBuilder: (context, index) {
          var event = events[index];
          return ListTile(
            title: Text(event['name']!),
            subtitle: Text(event['description']!),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => EventDetails(event: event)),
              );
            },
          );
        },
      ),
    );
  }
}
