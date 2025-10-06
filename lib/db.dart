import 'dart:async';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DB {
  static late Future<Database> database;
  static Future<Database> initDB() async {
    database = openDatabase(
      join(await getDatabasesPath(), 'sqlite.db'),
      onCreate: (db, version) {
        return db.execute(
          "CREATE TABLE listings(id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT NOT NULL, price REAL NOT NULL, status TEXT DEFAULT 'listed', desc TEXT)",
        );
      },

      onConfigure: (db) {
        return db.execute('PRAGMA foriegn_keys = ON');
      },

      onOpen: (db) async {
        await db.execute('''
          CREATE TABLE IF NOT EXISTS listings(
              id INTEGER PRIMARY KEY AUTOINCREMENT,
              name TEXT NOT NULL,
              price REAL NOT NULL,
              status TEXT DEFAULT 'listed',
              desc TEXT)
              ''');

        await db.execute('''
            CREATE TABLE IF NOT EXISTS expenses(
              id INTEGER PRIMARY KEY AUTOINCREMENT,
              listing_id INTEGER NOT NULL,
              name TEXT NOT NULL,
              amount REAL NOT NULL,
              desc TEXT,
              FOREIGN KEY (listing_id) REFERENCES listings (id)
                ON UPDATE CASCADE
                ON DELETE CASCADE)
              ''');
      },
      version: 2,
    );
    return database;
  }
}
