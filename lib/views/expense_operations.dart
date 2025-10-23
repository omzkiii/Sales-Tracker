import 'package:app/controllers/expense.dart';
import 'package:app/models/expenses.dart';
import 'package:flutter/material.dart';

class ExpenseNotifier extends ChangeNotifier {
  final GlobalKey<AnimatedListState> listKey = GlobalKey<AnimatedListState>();
  final List<Expense> list = [];

  double get totalExpenses =>
      list.map((e) => e.amount).fold(0.0, (total, amount) => total + amount);

  Future<void> loadExpenses(int listingId) async {
    print("Expenses Loaded");
    final loaded = await expenses(listingId);
    list.clear();
    list.addAll(loaded);
    notifyListeners();
  }

  void addToExpenses(Expense expense) async {
    int id = await insertExpense(expense);
    expense.id = id;
    list.add(expense);
    listKey.currentState?.insertItem(list.length - 1);
    notifyListeners();
  }

  void modifyExpenses(Expense expense) async {
    await updateExpense(expense);
    int index = list.indexWhere((el) => el.id == expense.id);
    list[index] = expense;
    listKey.currentState?.removeItem(
      index,
      (context, animation) => SizeTransition(sizeFactor: animation),
    );
    listKey.currentState?.insertItem(index);
    notifyListeners();
  }

  void removeFromExpenses(Expense expense, int index, Widget child) {
    print("WILL REMOVE: $expense");
    list.removeAt(index);
    listKey.currentState?.removeItem(
      index,
      (context, animation) =>
          SizeTransition(sizeFactor: animation, child: child),
    );
    notifyListeners();
    deleteExpense(expense.id!);
  }
}
