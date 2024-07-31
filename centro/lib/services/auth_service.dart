import 'package:sqflite/sqflite.dart';
import 'db_service.dart';
import '../models/usuario.dart';

class AuthService {
  final DatabaseService _databaseService = DatabaseService();

  Future<void> registerUser(Usuario usuario) async {
    Database db = await _databaseService.database;
    await db.insert('usuarios', usuario.toMap(), conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<Usuario?> loginUser(String matricula, String password) async {
    Database db = await _databaseService.database;
    List<Map<String, dynamic>> maps = await db.query(
      'usuarios',
      where: 'matricula = ? AND password = ?',
      whereArgs: [matricula, password],
    );

    if (maps.isNotEmpty) {
      return Usuario.fromMap(maps.first);
    } else {
      return null;
    }
  }
}
