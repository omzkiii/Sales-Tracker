import 'package:app/models/listing.dart';
import 'package:app/views/item.dart';
import 'package:flutter/material.dart';

class ListingCard extends StatelessWidget {
  final Listing listing;
  const ListingCard({super.key, required this.listing});

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: "${listing.id}",
      child: ListTile(
        title: Text(listing.name),
        subtitle: Text(listing.price.toString()),
        tileColor: Colors.red,
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => Item(item: listing)),
          );
        },
      ),
    );
  }
}
