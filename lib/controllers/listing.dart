import 'package:app/db.dart';
import 'package:app/models/listing.dart';
import 'package:sqflite/sqflite.dart';

Future<void> insertListing(Listing listing) async {
  Database db = await DB.initDB();
  await db.insert(
    "listings",
    listing.toMap(),
    conflictAlgorithm: ConflictAlgorithm.replace,
  );
}

Future<List<Listing>> listings() async {
  Database db = await DB.initDB();
  List<Map<String, Object?>> map = await db.query("listings");
  List<Listing> listings = map.map((item) => Listing.toObject(item)).toList();
  return listings;
}

Future<Listing> getListing(int id) async {
  Database db = await DB.initDB();
  List<Map<String, Object?>> map = await db.query(
    "listings",
    where: "id = ?",
    whereArgs: [id],
    limit: 1,
  );
  List<Listing> listings = map.map((item) => Listing.toObject(item)).toList();
  return listings[0];
}

Future<void> deleteListing(int id) async {
  Database db = await DB.initDB();
  await db.delete("listings", where: "id = ?", whereArgs: [id]);
}

Future<void> updateListing(Listing listing) async {
  Database db = await DB.initDB();
  print("UPDATING: $listing");
  await db.update(
    "listings",
    listing.toMap(),
    where: "id = ?",
    whereArgs: [listing.id],
  );
}

Future<void> updateListingStatus(Listing listing, String status) async {
  Database db = await DB.initDB();
  print("UPDATING: ${listing.name} status");
  var newListing = listing.copyWith(status: status);
  print(newListing);
  await db.update(
    "listings",
    newListing.toMap(),
    where: "id = ?",
    whereArgs: [newListing.id],
  );
}
