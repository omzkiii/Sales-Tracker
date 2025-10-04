import 'package:app/controllers/listing.dart';
import 'package:app/models/listing.dart';
import 'package:flutter/material.dart';

class Listings extends StatelessWidget {
  const Listings({super.key});

  @override
  Widget build(BuildContext context) {
    var listenable = ListingNotifier();
    return Scaffold(
      body: Column(
        children: [
          ListenableBuilder(
            listenable: listenable,
            builder: (context, child) {
              listenable.loadList();
              return Expanded(
                child: ListView(
                  children: listenable.list
                      .map((elem) => ListingCard(listing: elem))
                      .toList(),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

class ListingCard extends StatelessWidget {
  final Listing listing;
  const ListingCard({super.key, required this.listing});

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: "Listing",
      child: ListTile(
        title: Text(listing.name),
        subtitle: Text(listing.price.toString()),
        tileColor: Colors.red,
        onTap: () {
          print("item: ${listing.name}");
        },
      ),
    );
  }
}

class ListingNotifier extends ChangeNotifier {
  List<Listing> _list = [];
  List<Listing> get list => _list;

  void addToList(Listing listing) async {
    insertListing(listing);
    await loadList();
  }

  Future<void> loadList() async {
    _list = await listings();
    notifyListeners();
  }
}
