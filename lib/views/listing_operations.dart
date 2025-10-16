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
    await insertListing(listing);
    loadList();
  }

  Future<void> changeListing(Listing listing) async {
    await updateListing(listing);
    loadList();
  }

  Future<void> removeFromListing(int id) async {
    await deleteListing(id);
    loadList();
  }
}
