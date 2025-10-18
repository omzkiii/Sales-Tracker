import 'package:app/models/listing.dart';
import 'package:app/views/item.dart';
import 'package:app/views/listing_operations.dart';
import 'package:flutter/material.dart';

class Listings extends StatelessWidget {
  final ListingNotifier listingNotifier;
  final String status;
  const Listings({
    super.key,
    required this.listingNotifier,
    required this.status,
  });

  @override
  Widget build(BuildContext context) {
    listingNotifier.loadList();
    print("LOADED");
    return Scaffold(
      body: Column(
        children: [
          ListenableBuilder(
            listenable: listingNotifier,
            builder: (context, child) {
              return Expanded(
                child: ListView(
                  children: listingNotifier.list
                      .where((elem) => elem.status == status)
                      .map(
                        (elem) => ListingCard(
                          listing: elem,
                          listingNotifier: listingNotifier,
                        ),
                      )
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
  final ListingNotifier listingNotifier;
  const ListingCard({
    super.key,
    required this.listing,
    required this.listingNotifier,
  });

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: "${listing.id}",
      child: ListTile(
        title: Text(listing.name),
        subtitle: Text(listing.price.toString()),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) =>
                  Item(item: listing, listingNotifier: listingNotifier),
            ),
          );
        },
      ),
    );
  }
}
