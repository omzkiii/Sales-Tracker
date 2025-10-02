import 'package:app/db.dart';
import 'package:app/models/listing.dart';
import 'package:sqflite/sqflite.dart';

void insertListing(Listing listing) async {
  Database db = await DB.init();
  db.insert(
    "listing",
    listing.toMap(),
    conflictAlgorithm: ConflictAlgorithm.replace,
  );
}

// Future<List<Listing>> listings() async {}
