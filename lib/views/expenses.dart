import 'package:app/controllers/expense.dart';
import 'package:app/models/expenses.dart';
import 'package:flutter/material.dart';

class Expenses extends StatelessWidget {
  const Expenses({super.key});

  @override
  Widget build(BuildContext context) {
    var listenable = ExpensesNotifier();
    return ListenableBuilder(
      listenable: listenable,
      builder: (context, child) {
        return Column(children: []);
      },
    );
  }
}

class ExpensesNotifier extends ChangeNotifier {
  List<Expense> list = [];

  Future<void> getExpenses() async {
    list = await expenses();
  }
}
