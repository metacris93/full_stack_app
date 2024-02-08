import 'dart:io';

import 'package:full_stack_app/database/dao/user_dao.dart';
import 'package:full_stack_app/database/dao/user_location_dao.dart';
import 'package:full_stack_app/models/user_sign_in.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DBProvider {
  DBProvider._();
  static final DBProvider instance = DBProvider._();
  Database? _database;
  int versionDB = 3;

  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    }
    _database = await _initDB();
    return _database!;
  }

  void setDatabase(Database database) {
    _database = database;
  }

  _initDB() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, 'full_stack_database.db');
    return await openDatabase(
      path,
      version: versionDB,
      onCreate: _onCreate,
      onUpgrade: _onUpgrade,
    );
  }

  Future<UserSignIn?> getCurrentUser() async {
    final db = await database;
    List<Map<String, dynamic>> users = await db.rawQuery('SELECT * FROM users');
    if (users.isNotEmpty) {
      return UserSignIn.fromStorage(users.first);
    }
    return null;
  }

  _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE dogs(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT,
        age INTEGER
      )
    ''');
    await db.execute(UserDao().createTableQuery);
  }

  _onUpgrade(Database db, int oldVersion, int newVersion) async {
    if (oldVersion < versionDB) {
      await db.execute(UserLocationDao().createTableQuery);
    }
  }
}
