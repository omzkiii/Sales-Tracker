import 'package:app/models/listing.dart';
import 'package:app/settings/currency.dart';
import 'package:app/views/delete_dialog.dart';
import 'package:app/views/expense_operations.dart';
import 'package:app/views/expenses.dart';
import 'package:app/views/form_expense.dart';
import 'package:app/views/form_listing.dart';
import 'package:app/views/listing_operations.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';

class Item extends StatefulWidget {
  final Listing item;
  final ListingNotifier listingNotifier;
  const Item({super.key, required this.item, required this.listingNotifier});

  @override
  State<Item> createState() => _ItemState();
}

class _ItemState extends State<Item> {
  late String status;
  late Listing listing;
  @override
  void initState() {
    super.initState();
    status = widget.item.status;
    listing = widget.item;
  }

  @override
  Widget build(BuildContext context) {
    var expenseNotifier = ExpenseNotifier();
    print("ITEM RELOAD: ${widget.item.status}");
    return Scaffold(
      appBar: AppBar(
        title: Text(listing.name),
        actions: [
          Container(
            alignment: Alignment.bottomRight,
            child: FilledButton(
              style: FilledButton.styleFrom(
                backgroundColor: status == "sold"
                    ? Theme.of(context).colorScheme.primary
                    : Theme.of(context).colorScheme.tertiary,
              ),
              onPressed: () {
                setState(() {
                  status = status == "sold" ? "listed" : "sold";
                });
                widget.listingNotifier.changeListingStatus(listing, status);
              },
              child: Text(status.toUpperCase()),
            ),
          ),
          IconButton(
            icon: Icon(Icons.edit),
            onPressed: () async {
              var result = await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => FormListing(
                    isNew: false,
                    listing: listing,
                    listingNotifier: widget.listingNotifier,
                  ),
                ),
              );
              setState(() {
                listing = result;
              });
            },
          ),
          IconButton(
            icon: Icon(Icons.delete),
            onPressed: () async {
              String? result = await showDeleteDialog(context, listing.name, [
                listing.id!,
              ], widget.listingNotifier.removeFromListing);
              if (!context.mounted) return;
              if (result == 'OK') {
                Navigator.pop(context);
              }
            },
            // widget.listingNotifier.removeFromListing(listing.id!);
          ),
        ],
      ),
      body: Container(
        color: Theme.of(context).hoverColor,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              color: Theme.of(context).colorScheme.secondaryFixedDim,
              padding: EdgeInsets.all(21),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ValueListenableBuilder(
                    valueListenable: currency,
                    builder: (context, value, child) {
                      return Text(
                        "${currency.value.symbol} ${listing.priceFixed}",
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 21,
                          color: Theme.of(context).colorScheme.onSecondaryFixed,
                        ),
                      );
                    },
                  ),
                  Text(listing.desc, style: TextStyle(fontSize: 16)),
                ],
              ),
            ),

            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              width: double.infinity,
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surface,
              ),
              child: Text(
                "Expenses",
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.surfaceTint,
                ),
              ),
            ),
            Expenses(listingId: listing.id!, expenseNotifier: expenseNotifier),
          ],
        ),
      ),

      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      floatingActionButton: FloatingActionButton.extended(
        icon: Icon(Icons.add),
        label: Text("Add Expense"),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => FormExpense(
                listingId: listing.id!,
                expenseNotifier: expenseNotifier,
                isNew: true,
              ),
            ),
          );
        },
      ),
      bottomNavigationBar: BottomAppBar(
        child: ListenableBuilder(
          listenable: expenseNotifier,
          builder: (context, child) {
            return ValueListenableBuilder(
              valueListenable: currency,
              builder: (context, value, child) {
                double profit = listing.price - expenseNotifier.totalExpenses;
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Total Expenses: ${currency.value.symbol} ${expenseNotifier.totalExpenses.toStringAsFixed(2)}",
                      style: TextStyle(fontSize: 16),
                    ),
                    Text(
                      "Total Profit: ${currency.value.symbol} ${profit.toStringAsFixed(2)}",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w900,
                        color: profit > 0
                            ? Colors.lightGreen
                            : Colors.redAccent,
                      ),
                    ),
                  ],
                );
              },
            );
          },
        ),
      ),
    );
  }
}
