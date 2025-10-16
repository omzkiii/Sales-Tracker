import 'package:app/models/expenses.dart';
import 'package:app/views/expense_operations.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';

class Expenses extends StatelessWidget {
  final int listingId;
  final ExpenseNotifier expenseNotifier;
  Expenses({super.key, required this.listingId, required this.expenseNotifier});

  final selected = ValueNotifier<int>(-1);

  @override
  Widget build(BuildContext context) {
    expenseNotifier.loadExpenses(listingId);
    return ListenableBuilder(
      listenable: expenseNotifier,
      builder: (context, child) {
        print(expenseNotifier.list);
        return Container(
          child: Expanded(
            child: ValueListenableBuilder(
              valueListenable: selected,
              builder: (context, value, _) {
                return ListView(
                  children: expenseNotifier.list
                      .map(
                        (item) =>
                            ExpenseCard(expense: item, selected: selected),
                      )
                      .toList(),
                );
              },
            ),
          ),
        );
      },
    );
  }
}

class ExpenseCard extends StatelessWidget {
  final Expense expense;
  final ValueNotifier<int> selected;
  const ExpenseCard({super.key, required this.expense, required this.selected});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      minTileHeight: 1,
      title: Text(expense.name),
      subtitle: AnimatedSize(
        alignment: Alignment.topCenter,
        duration: Duration(milliseconds: 200),
        curve: Curves.linearToEaseOut,
        child: selected.value == expense.id
            ? Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("PHP ${expense.amount}"),
                      Text("${expense.desc}"),
                    ],
                  ),
                  IconButton(
                    onPressed: () => print("delete"),
                    icon: Icon(Icons.delete),
                  ),
                ],
              )
            : Text("PHP ${expense.amount}"),
      ),
      onTap: () => {
        selected.value = selected.value == expense.id! ? -1 : expense.id!,
      },
    );
  }
}
