import 'package:app/db.dart';
import 'package:sqflite/sqflite.dart';

Future<String> getSetting(String key) async {
  Database db = await DB.initDB();
  List<Map<String, Object?>> map = await db.query(
    "settings",
    where: "key = ?",
    whereArgs: [key],
    limit: 1,
  );
  List<String> settings = map.map((item) => item["val"].toString()).toList();
  return settings[0];
}
