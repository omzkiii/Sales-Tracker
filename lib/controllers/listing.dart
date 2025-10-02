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

Future<List<Listing>> listings() async {
  Database db = await DB.init();
  List<Map<String, Object?>> map = await db.query("listings");
  List<Listing> listings = map.map((item) => Listing.toObject(item)).toList();
  return listings;
}
