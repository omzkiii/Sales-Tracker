import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DB {
  static late Future<Database> database;
  static Future<Database> init() async {
    WidgetsFlutterBinding.ensureInitialized();
    database = openDatabase(
      join(await getDatabasesPath(), 'sqlite.db'),
      onCreate: (db, version) {
        return db.execute(
          'CREATE TABLE listings(id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT NOT NULL, price REAL NOT NULL, status TEXT DEFAULT "listed", desc TEXT)',
        );
      },
      version: 1,
    );
    return database;
  }
}
