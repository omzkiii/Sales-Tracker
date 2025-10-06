import 'package:app/db.dart';
import 'package:app/models/expenses.dart';
import 'package:sqflite/sqflite.dart';

Future<void> insertExpense(Expense expense) async {
  Database db = await DB.initDB();
  await db.insert(
    "expenses",
    expense.toMap(),
    conflictAlgorithm: ConflictAlgorithm.replace,
  );
}

Future<List<Expense>> expenses() async {
  Database db = await DB.initDB();
  List<Map<String, Object?>> map = await db.query("expenses");
  List<Expense> expenses = map.map((item) => Expense.toObject(item)).toList();
  return expenses;
}

Future<Expense> getExpense(int id) async {
  Database db = await DB.initDB();
  List<Map<String, Object?>> map = await db.query(
    "expenses",
    where: "id = ?",
    whereArgs: [id],
    limit: 1,
  );
  List<Expense> expenses = map.map((item) => Expense.toObject(item)).toList();
  return expenses[0];
}

Future<void> deleteExpense(int id) async {
  Database db = await DB.initDB();
  await db.delete("expenses", where: "id = ?", whereArgs: [id]);
}

Future<void> updateExpense(Expense expense) async {
  Database db = await DB.initDB();
  print("UPDATING: $expense");
  await db.update(
    "expenses",
    expense.toMap(),
    where: "id = ?",
    whereArgs: [expense.id],
  );
}
