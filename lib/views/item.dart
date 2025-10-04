import 'package:app/controllers/listing.dart';
import 'package:app/models/listing.dart';
import 'package:flutter/material.dart';

class Item extends StatelessWidget {
  final Listing listing;
  const Item({super.key, required this.listing});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(listing.name)),
      body: Column(
        children: [
          Text("Price: ${listing.price}"),
          Text("Description: ${listing.desc}"),
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
  }
}
