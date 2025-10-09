import 'package:app/controllers/listing.dart';
import 'package:app/models/listing.dart';
import 'package:app/views/item.dart';
import 'package:app/views/listing_card.dart';
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

class ListingNotifier extends ChangeNotifier {
  List<Listing> _list = [];
  List<Listing> get list => _list;

  Future<void> loadList() async {
    _list = await listings();
    notifyListeners();
  }
}
