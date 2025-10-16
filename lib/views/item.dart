import 'package:app/controllers/listing.dart';
import 'package:app/models/listing.dart';
import 'package:app/views/expenses.dart';
import 'package:app/views/form_expense.dart';
import 'package:app/views/form_listing.dart';
import 'package:app/views/listing_operations.dart';
import 'package:flutter/material.dart';

class Item extends StatelessWidget {
  final Listing item;
  final ListingNotifier listingNotifier;
  const Item({super.key, required this.item, required this.listingNotifier});

  @override
  Widget build(BuildContext context) {
    var listenable = ItemNotifier();
    return ListenableBuilder(
      listenable: listenable,
      builder: (context, child) {
        Listing listing = listenable.item ?? item;
        return Scaffold(
          appBar: AppBar(title: Text(listing.name)),
          body: Column(
            children: [
              Text("Price: ${listing.price}"),
              Text("Description: ${listing.desc}"),
              Expenses(listingId: listing.id!),
              ElevatedButton(
                onPressed: () async {
                  var result = await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => FormListing(
                        isNew: false,
                        listing: listing,
                        listenable: listingNotifier,
                      ),
                    ),
                  );
                  if (result == true) {
                    listenable.refreshItem(listing.id!);
                  }
                },
                child: Text("Edit Listing"),
              ),
              ElevatedButton(
                onPressed: () {
                  listingNotifier.removeFromListing(listing.id!);
                  Navigator.pop(context);
                },
                child: Text("Delete Listing"),
              ),
              ElevatedButton(
                onPressed: () async {
                  var result = await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => FormExpense(listingId: listing.id!),
                    ),
                  );
                },
                child: Text("Add Expense"),
              ),
            ],
          ),
        );
      },
    );
  }
}

class ItemNotifier extends ChangeNotifier {
  Listing? item;

  Future<void> refreshItem(int id) async {
    item = await getListing(id);
    notifyListeners();
    print("Item refreshed");
  }
}
