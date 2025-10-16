import 'package:app/controllers/listing.dart';
import 'package:app/models/listing.dart';
import 'package:flutter/material.dart';

class ListingNotifier extends ChangeNotifier {
  List<Listing> _list = [];
  List<Listing> get list => _list;

  Future<void> loadList() async {
    _list = await listings();
    notifyListeners();
  }

  Future<void> insertToListings(Listing listing) async {
    print("LISTING ADDED");
    await insertListing(listing);
    loadList();
    // notifyListeners();
  }
}
