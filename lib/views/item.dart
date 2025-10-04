import 'package:app/controllers/listing.dart';
import 'package:app/models/listing.dart';
import 'package:app/views/form_listing.dart';
import 'package:flutter/material.dart';

class Item extends StatelessWidget {
  final Listing item;
  const Item({super.key, required this.item});

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
              ElevatedButton(
                onPressed: () async {
                  var result = await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          FormListing(isNew: false, listing: listing),
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
                  deleteListing(listing.id!);
                  Navigator.pop(context);
                },
                child: Text("Delete Listing"),
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
