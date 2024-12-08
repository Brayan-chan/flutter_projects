import 'package:encrypt/encrypt.dart';

class Task {
  final int id;
  final String description; // Encriptado
  final DateTime registeredAt;
  final DateTime scheduledTime;

  Task({
    required this.id,
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
      description: _decrypt(map['description']),
      registeredAt: DateTime.parse(map['registeredAt']),
      scheduledTime: DateTime.parse(map['scheduledTime']),
    );
  }

  // Métodos de encriptación/desencriptación
  static String _encrypt(String plainText) {
    final key = Key.fromUtf8('your-32-character-key');
    final iv = IV.fromLength(16);
    final encrypter = Encrypter(AES(key));
    return encrypter.encrypt(plainText, iv: iv).base64;
  }

  static String _decrypt(String encryptedText) {
    final key = Key.fromUtf8('your-32-character-key');
    final iv = IV.fromLength(16);
    final encrypter = Encrypter(AES(key));
    return encrypter.decrypt64(encryptedText, iv: iv);
  }
}
