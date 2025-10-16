import 'package:app/controllers/expense.dart';
import 'package:app/models/expenses.dart';
import 'package:flutter/material.dart';

class ExpenseNotifier extends ChangeNotifier {
  final GlobalKey<AnimatedListState> listKey = GlobalKey<AnimatedListState>();
  final List<Expense> list = [];

  Future<void> loadExpenses(int listingId) async {
    print("Expenses Loaded");
    final loaded = await expenses(listingId);
    list.clear();
    list.addAll(loaded);
    notifyListeners();
  }

  void addToExpenses(Expense expense) {
    list.add(expense);
    listKey.currentState?.insertItem(list.length - 1);
    insertExpense(expense);
  }

  void removeFromExpenses(Expense expense, int index, Widget child) {
    list.removeAt(index);
    listKey.currentState?.removeItem(
      index,
      (context, animation) =>
          SizeTransition(sizeFactor: animation, child: child),
    );
    deleteExpense(expense.id!);
  }
}
