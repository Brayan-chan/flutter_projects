import 'package:encrypt/encrypt.dart';
class Task {
  final int? id; // Puede ser null para nuevas tareas
  final String description; // Será encriptado
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
      'id': id, // Ignorado si es null
      'description': _encrypt(description), // Descripción cifrada
      'registeredAt': registeredAt.toIso8601String(),
      'scheduledTime': scheduledTime.toIso8601String(),
    };
  }

  static Task fromMap(Map<String, dynamic> map) {
    return Task(
      id: map['id'], // ID generado por SQLite
      description: _tryDecrypt(map['description']), // Intentar desencriptar
      registeredAt: DateTime.parse(map['registeredAt']),
      scheduledTime: DateTime.parse(map['scheduledTime']),
    );
  }

  static String _encrypt(String plainText) {
    final key = Key.fromBase64(AES_KEY); // Usar la clave desde constants.dart
    final iv = IV.fromLength(16); // Generar IV aleatorio
    final encrypter = Encrypter(AES(key, mode: AESMode.cbc)); // Modo CBC

    // Retornar formato esperado: "IV:CipherText"
    final encrypted = encrypter.encrypt(plainText, iv: iv);
    return '${iv.base64}:${encrypted.base64}';
  }

  static String _tryDecrypt(String encryptedText) {
    try {
      // Dividir en IV y CipherText
      final parts = encryptedText.split(':');
      if (parts.length != 2) {
        // Si no cumple el formato esperado, retornar el texto original
        return encryptedText;
      }

      final iv = IV.fromBase64(parts[0]);
      final cipherText = parts[1];

      final key = Key.fromBase64(AES_KEY); // Usar la clave desde constants.dart
      final encrypter = Encrypter(AES(key, mode: AESMode.cbc));

      // Intentar desencriptar
      return encrypter.decrypt64(cipherText, iv: iv);
    } catch (e) {
      // Si falla la desencriptación, retornar el texto original
      return encryptedText;
    }
  }
}

const String AES_KEY = 'MJ0ch4jL45lusyPLMvDCJHB+gKCK+EXTbOaLchjNbxAge6Ch31LtLHVzq5dCOY0v';