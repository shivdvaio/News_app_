import 'dart:io';
import 'package:collection/collection.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static final _dbName = 'myDatabase.db';
  static final _dbVersion = 1;
  static final _tableName = "myTable";
  static final columnId = '_id';
  static final columnName = 'name';
  static final imageAddress = "imageAdd";
  static final title  = "titleArticle";
  static final htmlData = "dataHtml";

  DatabaseHelper._privateconstructor();

  static final DatabaseHelper instance = DatabaseHelper._privateconstructor();

  static Database _database;

  Future<Database> get database async {
    if (_database != null) return _database;

    _database = await _initateDatabase();
    return _database;
  }

  _initateDatabase() async {  
    Directory directory = await getApplicationDocumentsDirectory();
    String path = join(directory.path, _dbName);
    return await openDatabase(path, version: _dbVersion, onCreate: _onCreate);
  }

   _onCreate(Database db, int version) {
    db.execute('''
    
        CREATE TABLE $_tableName (
          
        $columnId INTEGER PRIMARY KEY,
        $imageAddress STRING,
        $title STRING,
        $htmlData  STRING,
        $columnName STRING)
           
       ''');
  }

  Future<int> insert(Map<String, dynamic> row) async {
    Database db = await instance.database;
    return await db.insert(_tableName, row);
  }

  Future<List<Map<String, dynamic>>> queryAll() async {
    Database db = await instance.database;
    return db.query(_tableName);
  }

  Future update(Map<String, dynamic> row) async {
    Database db = await instance.database;
    int id = row[columnId];
   
   return  await db.update(_tableName, row,
        where: '$columnId = ? ', whereArgs: [id, ]);
  }

  Future<int> delete({int id}) async {
    Database db = await instance.database;
    return await db
        .delete(_tableName, where: '$columnId = ? ', whereArgs: [id]);
  }
}
