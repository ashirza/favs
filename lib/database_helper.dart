import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';

class DatabaseHelper{

  static final _dbName = 'theDatabase.db';
  static final _dbVersion = 1;
  static final _gameTableName = 'gaming';

  static final columnId = 'id';
  static final columnName = 'name';
  static final columnRating = 'rating';
  static final columnUrl = 'url';

  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  static Database _database;
  Future<Database> get database async{
    if(_database != null) {
      return _database;
    } else {
      _database = await _initiateDatabase();
      return _database;
    }
  }

  _initiateDatabase() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = join(directory.path, _dbName);
    return await openDatabase(path, version: _dbVersion, onCreate: _onCreate);

  }

  Future _onCreate(Database db, int version) {
    db.execute(
      '''
      CREATE TABLE $_gameTableName(
      $columnId INTEGER PRIMARY KEY,
      $columnName TEXT NOT NULL,
      $columnRating INTEGER,
      $columnUrl TEXT NOT NULL)
      '''
    );
  }

  Future<int> insert(Map<String,dynamic> row) async {
    Database db = await instance.database; //from the present instance, get db
    return await db.insert(_gameTableName, row);
  }

  Future<List<Map<String,dynamic>>> queryAll() async {
    Database db = await instance.database;
    return await db.query(_gameTableName);
  }

  Future update(Map<String,dynamic> row) async {
    Database db = await instance.database;
    int id = row[columnId];
    return await db.update(_gameTableName, row, where: '$columnId = ?', whereArgs: [id
    ]);
  }

  Future<int> delete(int id) async {
    Database db = await instance.database;
    return await db.delete(_gameTableName, where: '$columnId = ?', whereArgs: [id]);

  }
}