import 'package:app/models/expenses.dart';
import 'package:app/views/expense_operations.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';

class Expenses extends StatefulWidget {
  final int listingId;
  final ExpenseNotifier expenseNotifier;
  Expenses({super.key, required this.listingId, required this.expenseNotifier});

  @override
  State<Expenses> createState() => _ExpensesState();
}

class _ExpensesState extends State<Expenses> {
  final selected = ValueNotifier<int>(-1);

  @override
  Widget build(BuildContext context) {
    final GlobalKey<AnimatedListState> listKey = widget.expenseNotifier.listKey;
    return FutureBuilder(
      future: widget.expenseNotifier.loadExpenses(widget.listingId),
      builder: (context, asyncSnapshot) {
        if (asyncSnapshot.connectionState != ConnectionState.done) {
          return const Center(child: CircularProgressIndicator());
        }
        return Expanded(
          child: ValueListenableBuilder<int>(
            valueListenable: selected,
            builder: (context, value, _) {
              print(
                "BUILDER LIST LENGTH: ${widget.expenseNotifier.list.length}",
              );
              return AnimatedList(
                key: listKey,
                initialItemCount: widget.expenseNotifier.list.length,
                itemBuilder: (context, index, animation) {
                  print("BUILDER INDEX: $index");
                  var item = widget.expenseNotifier.list[index];
                  return SlideTransition(
                    position: animation.drive(
                      Tween<Offset>(
                        begin: Offset(0, 0.1),
                        end: Offset(0, 0.1),
                      ).chain(CurveTween(curve: Curves.easeInOut)),
                    ),
                    child: ExpenseCard(
                      expense: item,
                      selected: selected,
                      expenseNotifier: widget.expenseNotifier,
                      index: index,
                    ),
                  );
                },
              );
            },
          ),
        );
      },
    );
  }
}

class ExpenseCard extends StatelessWidget {
  final Expense expense;
  final ValueNotifier<int> selected;
  final ExpenseNotifier expenseNotifier;
  final int index;
  const ExpenseCard({
    super.key,
    required this.expense,
    required this.selected,
    required this.expenseNotifier,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      minTileHeight: 1,
      title: Text(expense.name),
      subtitle: AnimatedSize(
        alignment: Alignment.topCenter,
        duration: Duration(milliseconds: 200),
        curve: Curves.linearToEaseOut,
        child: selected.value == index
            ? Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("PHP ${expense.amount}"),
                      Text(expense.desc),
                    ],
                  ),
                  IconButton(
                    onPressed: () {
                      expenseNotifier.removeFromExpenses(expense, index, this);
                    },

                    icon: Icon(Icons.delete),
                  ),
                ],
              )
            : Text("PHP ${expense.amount} ||||| INDEX : $index"),
      ),
      onTap: () => {selected.value = selected.value == index ? -1 : index},
    );
  }
}
