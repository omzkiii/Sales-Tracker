import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class Listing {
  final int id;
  final String name;
  final int price;
  final String status;
  final String desc;

  Listing({
    required this.id,
    required this.name,
    required this.price,
    required this.status,
    required this.desc,
  });

  Map<String, Object?> toMap() {
    return {
      'id': id,
      'name': name,
      'age': price,
      'status': status,
      'desc': desc,
    };
  }

  @override
  String toString() {
    return 'Listing{id: $id, name: $name, age: $price, status: $status, desc: $desc}';
  }
}

class DB {
  static late Future<Database> database;
  static Future<Database> init() async {
    WidgetsFlutterBinding.ensureInitialized();
    database = openDatabase(
      join(await getDatabasesPath(), 'sqlite.db'),
      onCreate: (db, version) {
        return db.execute(
          'CREATE TABLE listings(id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT NOT NULL, price REAL NOT NULL, status TEXT DEFAULT "listed", description TEXT)',
        );
      },
      version: 1,
    );
    return database;
  }
}
