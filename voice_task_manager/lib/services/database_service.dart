import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/task.dart';

class DatabaseService {
  static final DatabaseService _instance = DatabaseService._();
  static Database? _database;

  DatabaseService._();

  factory DatabaseService() => _instance;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'tasks.db');

    return openDatabase(
      path,
      version: 1,
      onCreate: (db, version) {
        db.execute('''
          CREATE TABLE tasks (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            description TEXT,
            registeredAt TEXT,
            scheduledTime TEXT
          )
        ''');
      },
    );
  }

  Future<int> insertTask(Task task) async {
    final db = await database;
    return db.insert('tasks', task.toMap());
  }

  Future<List<Task>> getTasks() async {
    final db = await database;
    final result = await db.query('tasks');
    return result.map((map) => Task.fromMap(map)).toList();
  }

  Future<List<Task>> getTasksAtTime(DateTime time) async {
    final db = await database;
    final result = await db.query(
      'tasks',
      where: 'scheduledTime = ?',
      whereArgs: [time.toIso8601String()],
    );
    return result.map((map) => Task.fromMap(map)).toList();
  }

  // Nuevo método para limpiar la tabla "tasks"
  Future<void> clearTasksTable() async {
    final db = await database;
    await db.delete('tasks');
    print('Tabla "tasks" limpiada exitosamente');
  }
}
