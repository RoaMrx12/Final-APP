import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import '../models/incidencia.dart';
import '../models/visita.dart';
import '../models/usuario.dart';

class DatabaseService {
  static final DatabaseService _instance = DatabaseService._internal();
  static Database? _database;

  factory DatabaseService() {
    return _instance;
  }

  DatabaseService._internal();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, 'app.db');
    return await openDatabase(path, version: 1, onCreate: _onCreate);
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE incidencias (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        titulo TEXT,
        centroEducativo TEXT,
        regional TEXT,
        distrito TEXT,
        fecha TEXT,
        descripcion TEXT,
        fotoPath TEXT,
        audioPath TEXT
      )
    ''');

    await db.execute('''
      CREATE TABLE visitas (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        cedulaDirector TEXT,
        codigoCentro TEXT,
        motivo TEXT,
        fotoPath TEXT,
        comentario TEXT,
        audioPath TEXT,
        latitud REAL,
        longitud REAL,
        fecha TEXT,
        hora TEXT
      )
    ''');

    await db.execute('''
      CREATE TABLE usuarios (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        nombre TEXT,
        apellido TEXT,
        matricula TEXT,
        password TEXT
      )
    ''');
  }

  Future<int> insertIncidencia(Incidencia incidencia) async {
    Database db = await database;
    return await db.insert('incidencias', incidencia.toMap());
  }

  Future<List<Incidencia>> fetchIncidencias() async {
    Database db = await database;
    List<Map<String, dynamic>> results = await db.query('incidencias');
    return results.map((map) => Incidencia.fromMap(map)).toList();
  }

  Future<int> insertVisita(Visita visita) async {
    Database db = await database;
    return await db.insert('visitas', visita.toMap());
  }

  Future<List<Visita>> fetchVisitas() async {
    Database db = await database;
    List<Map<String, dynamic>> results = await db.query('visitas');
    return results.map((map) => Visita.fromMap(map)).toList();
  }

  Future<void> deleteAll() async {
    Database db = await database;
    await db.delete('incidencias');
    await db.delete('visitas');
    await db.delete('usuarios');
  }
}
