import 'package:app/models/listing.dart';
import 'package:app/views/delete_dialog.dart';
import 'package:app/views/expense_operations.dart';
import 'package:app/views/expenses.dart';
import 'package:app/views/form_expense.dart';
import 'package:app/views/form_listing.dart';
import 'package:app/views/listing_operations.dart';
import 'package:flutter/material.dart';

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
            child: TextButton(
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.all(21),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "₱ ${listing.priceFixed}",
                    style: TextStyle(
                      fontSize: 18,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                  Text(listing.desc),
                ],
              ),
            ),

            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              width: double.infinity,
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surface,
                border: Border(
                  top: BorderSide(
                    color: Theme.of(context).hoverColor,
                    width: 1,
                  ),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Theme.of(context).shadowColor.withOpacity(0.2),
                    blurRadius: 4,
                    offset: const Offset(0, 6),
                  ),
                ],
              ),
              child: Text("Expenses", style: TextStyle(fontSize: 21)),
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
              ),
            ),
          );
        },
      ),
      bottomNavigationBar: BottomAppBar(
        child: ListenableBuilder(
          listenable: expenseNotifier,
          builder: (context, child) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Total Expenses: ₱ ${expenseNotifier.totalExpenses.toStringAsFixed(2)}",
                ),
                Text(
                  "Total Profit: ₱ ${(listing.price - expenseNotifier.totalExpenses).toStringAsFixed(2)}",
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
