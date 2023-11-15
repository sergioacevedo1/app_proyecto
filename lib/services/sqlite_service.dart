import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:app/models/models.dart';

class AnimalSQLiteService {
  static Database? _database;

  static final AnimalSQLiteService db = AnimalSQLiteService._();

  AnimalSQLiteService._();

  Future<Database?> get database async {
    if (_database != null) return _database;

    _database = await _initDB();

    return _database;
  }

  Future<Database> _initDB() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    final path = join(documentsDirectory.path, 'animales.db');
    print('Ruta base de datos');
    print(path);

    return await openDatabase(
      path,
      version: 1,
      onCreate: (Database db, int version) async {
        await db.execute('''
          CREATE TABLE animales ( 
            id TEXT PRIMARY KEY
            nombre TEXT,
            edad INTEGER,
            estado TEXT
          )
        ''');
      },
    );
  }

  Future<String> insertAnimal(AnimalModel animal) async {
    final db = await database;
    final String id = await db.insert('animales', animal.toJson());
    return id;
  }

  Future<int> updateAnimal(AnimalModel animal) async {
    final db = await database;

    final res = await db!.update(
      'animales',
      animal.toJson(),
      where: 'id = ?',
      whereArgs: [animal.id],
    );

    return res;
  }

  Future<int> deleteAnimal(int id) async {
    final db = await database;

    final res = await db!.delete(
      'animales',
      where: 'id = ?',
      whereArgs: [id],
    );

    return res;
  }

  Future<List<AnimalModel>> getAllAnimales() async {
    final db = await database;

    final res = await db!.query('animales');

    List<AnimalModel> list =
        res.isNotEmpty ? res.map((e) => AnimalModel.fromJson(e)).toList() : [];

    return list;
  }

  Future<AnimalModel?> getAnimalById(int id) async {
    final db = await database;

    final res = await db!.query(
      'animales',
      where: 'id = ?',
      whereArgs: [id],
    );

    return res.isNotEmpty ? AnimalModel.fromJson(res.first) : null;
  }
}
