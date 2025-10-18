import 'package:app/models/expenses.dart';
import 'package:app/views/delete_dialog.dart';
import 'package:app/views/expense_operations.dart';
import 'package:flutter/material.dart';

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
              return AnimatedList(
                key: listKey,
                initialItemCount: widget.expenseNotifier.list.length,
                itemBuilder: (context, index, animation) {
                  var item = widget.expenseNotifier.list[index];
                  return SlideTransition(
                    position: animation.drive(
                      Tween<Offset>(
                        begin: Offset(0, 0.1),
                        end: Offset(0, 0.1),
                      ).chain(CurveTween(curve: Curves.easeInOut)),
                    ),
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: index < widget.expenseNotifier.list.length
                              ? BorderSide(
                                  color: Theme.of(context).highlightColor,
                                  width: 1,
                                )
                              : BorderSide.none,
                        ),
                      ),
                      child: ExpenseCard(
                        expense: item,
                        selected: selected,
                        expenseNotifier: widget.expenseNotifier,
                        index: index,
                      ),
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
      tileColor: selected.value == index
          ? Theme.of(context).colorScheme.surface
          : null,
      minTileHeight: 1,
      title: Text(expense.name),
      subtitle: AnimatedSize(
        alignment: Alignment.topCenter,
        duration: Duration(milliseconds: 200),
        curve: Curves.linearToEaseOut,
        child: selected.value == index
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("₱ ${expense.amountFixed}"),
                      Text(expense.desc),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                        onPressed: () {
                          selected.value = -1;
                          print(expense);
                          expenseNotifier.removeFromExpenses(
                            expense,
                            index,
                            this,
                          );
                        },
                        child: Text(
                          "Edit",
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.secondary,
                          ),
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          selected.value = -1;
                          showDeleteDialog(
                            context,
                            expense.name,
                            [expense, index, this],
                            expenseNotifier.removeFromExpenses,
                          );
                          // expenseNotifier.removeFromExpenses(
                          //   expense,
                          //   index,
                          //   this,
                          // );
                        },
                        child: Text(
                          "Delete",
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.error,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              )
            : Container(
                alignment: AlignmentGeometry.centerRight,
                child: Text(
                  "₱ ${expense.amountFixed}",
                  style: TextStyle(color: Theme.of(context).colorScheme.error),
                ),
              ),
      ),
      onTap: () => {selected.value = selected.value == index ? -1 : index},
    );
  }
}
