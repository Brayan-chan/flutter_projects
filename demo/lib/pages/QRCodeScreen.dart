import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class QrCodeScreen extends StatelessWidget {
  final Map<String, String> event;

  const QrCodeScreen({Key? key, required this.event}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const const Text('Código QR'),
      ),
      body: Center(
        child: QrImage(
          data: 'Evento: ${event['name']}\nDescripción: ${event['description']}',
          version: QrVersions.auto,
          size: 200.0,
        ),
      ),
    );
  }
}