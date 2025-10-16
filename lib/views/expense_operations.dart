import 'package:app/controllers/expense.dart';
import 'package:app/models/expenses.dart';
import 'package:flutter/material.dart';

class ExpenseNotifier extends ChangeNotifier {
  List<Expense> list = [];

  Future<void> loadExpenses(int listingId) async {
    list = await expenses(listingId);
    notifyListeners();
  }

  Future<void> addToExpenses(Expense expense) async {
    await insertExpense(expense);
    loadExpenses(expense.listingId);
  }

  Future<void> removeFromExpenses(Expense expense) async {
    await deleteExpense(expense.id!);
    loadExpenses(expense.listingId);
  }
}
