import 'package:app/models/listing.dart';
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
          IconButton(
            icon: Icon(Icons.delete),
            onPressed: () {
              widget.listingNotifier.removeFromListing(listing.id!);
              Navigator.pop(context);
            },
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
        ],
      ),
      body: Column(
        children: [
          Text("Price: ${listing.price}"),
          Text("Status: ${status}"),
          Text("Description: ${listing.desc}"),
          FilledButton(
            onPressed: () {
              setState(() {
                status = status == "sold" ? "listed" : "sold";
              });
              print(status);
              widget.listingNotifier.changeListingStatus(listing, status);
            },
            child: Text(status),
          ),

          Expenses(listingId: listing.id!, expenseNotifier: expenseNotifier),
        ],
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
                Text("Total Expenses: PHP ${expenseNotifier.totalExpenses}"),
                Text(
                  "Total Profit: PHP ${listing.price - expenseNotifier.totalExpenses}",
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
