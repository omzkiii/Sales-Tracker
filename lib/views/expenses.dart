import 'package:app/controllers/expense.dart';
import 'package:app/models/expenses.dart';
import 'package:flutter/material.dart';

class Expenses extends StatelessWidget {
  final int listingId;
  const Expenses({super.key, required this.listingId});

  @override
  Widget build(BuildContext context) {
    var listenable = ExpenseNotifier();
    return ListenableBuilder(
      listenable: listenable,
      builder: (context, child) {
        listenable.getExpenses(listingId: listingId);
        return Expanded(
          child: ListView(
            children: listenable.list.map((item) => Text(item.name)).toList(),
          ),
        );
      },
    );
  }
}

class ExpenseNotifier extends ChangeNotifier {
  List<Expense> list = [];

  Future<void> getExpenses({required int listingId}) async {
    list = await expenses(listingId: listingId);
  }
}
