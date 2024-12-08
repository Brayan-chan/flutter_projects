import 'package:encrypt/encrypt.dart';

class Task {
  final int? id;
  final String description;
  final DateTime registeredAt;
  final DateTime scheduledTime;

  Task({
    this.id,
    required this.description,
    required this.registeredAt,
    required this.scheduledTime,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'description': _encrypt(description),
      'registeredAt': registeredAt.toIso8601String(),
      'scheduledTime': scheduledTime.toIso8601String(),
    };
  }

  static Task fromMap(Map<String, dynamic> map) {
    return Task(
      id: map['id'],
      description: _tryDecrypt(map['description']),
      registeredAt: DateTime.parse(map['registeredAt']),
      scheduledTime: DateTime.parse(map['scheduledTime']),
    );
  }

  static String _encrypt(String plainText) {
    final key = Key.fromBase64(AES_KEY); // Clave en Base64
    final iv = IV.fromLength(16); // Generar IV aleatorio
    final encrypter = Encrypter(AES(key, mode: AESMode.cbc));

    final encrypted = encrypter.encrypt(plainText, iv: iv);
    return '${iv.base64}:${encrypted.base64}';
  }

  static String _tryDecrypt(String encryptedText) {
    try {
      final parts = encryptedText.split(':');
      if (parts.length != 2) {
        return encryptedText;
      }

      final iv = IV.fromBase64(parts[0]);
      final cipherText = parts[1];

      final key = Key.fromBase64(AES_KEY); // Clave en Base64
      final encrypter = Encrypter(AES(key, mode: AESMode.cbc));

      return encrypter.decrypt64(cipherText, iv: iv);
    } catch (e) {
      return encryptedText;
    }
  }
}

const String AES_KEY = 'MTIzNDU2Nzg5MDEyMzQ1Njc4OTAxMjM0NTY3ODkwMTI=';
