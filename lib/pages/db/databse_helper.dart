import 'dart:io';

import 'package:face_net_authentication/pages/models/user.model.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';

class DatabaseHelper {
  static final _databaseName = "MyDatabase.db";
  static final _databaseVersion = 1;

  static final table = 'siswa';
  static final columnId = 'id';
  static final columnIdsiswa = 'idsiswa';
  static final columnNmsiswa = 'nmsiswa';
  static final columnModelData = 'model_data';

  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  static late Database _database;
  Future<Database> get database async {
    _database = await _initDatabase();
    return _database;
  }

  _initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, _databaseName);
    return await openDatabase(path,
        version: _databaseVersion, onCreate: _onCreate);
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
          CREATE TABLE $table (
            $columnId INTEGER PRIMARY KEY,
            $columnIdsiswa TEXT NOT NULL,
            $columnNmsiswa TEXT NOT NULL,
            $columnModelData TEXT NOT NULL
          )
          ''');
  }

  Future<int> insert(Siswa siswa) async {
    Database db = await instance.database;
    return await db.insert(table, siswa.toMap());
  }

  Future<List<Siswa>> queryAllSiswa() async {
    Database db = await instance.database;
    List<Map<String, dynamic>> siswas = await db.query(table);
    return siswas.map((u) => Siswa.fromMap(u)).toList();
  }

  Future<int> deleteAll() async {
    Database db = await instance.database;
    return await db.delete(table);
  }
}
