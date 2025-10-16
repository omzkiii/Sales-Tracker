import 'package:app/controllers/expense.dart';
import 'package:app/models/expenses.dart';
import 'package:app/views/expense_operations.dart';
import 'package:flutter/material.dart';

class Expenses extends StatelessWidget {
  final int listingId;
  final ExpenseNotifier expenseNotifier;
  const Expenses({
    super.key,
    required this.listingId,
    required this.expenseNotifier,
  });

  @override
  Widget build(BuildContext context) {
    expenseNotifier.loadExpenses(listingId);
    return ListenableBuilder(
      listenable: expenseNotifier,
      builder: (context, child) {
        print(expenseNotifier.list);
        return Container(
          child: Expanded(
            child: ListView(
              children: expenseNotifier.list
                  .map((item) => ExpenseCard(expense: item))
                  .toList(),
            ),
          ),
        );
      },
    );
  }
}

class ExpenseCard extends StatelessWidget {
  final Expense expense;
  const ExpenseCard({super.key, required this.expense});
  @override
  Widget build(BuildContext context) {
    var overlayController = OverlayPortalController();
    return ListTile(
      title: Text(expense.name),
      subtitle: OverlayPortal(
        controller: overlayController,
        overlayChildBuilder: (context) {
          return Text("PHP ${expense.amount}");
        },
      ),
    );
  }
}
