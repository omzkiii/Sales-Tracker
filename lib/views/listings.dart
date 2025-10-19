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
                        (elem) => Container(
                          padding: EdgeInsets.all(10),
                          child: ListingCard(
                            listing: elem,
                            listingNotifier: listingNotifier,
                          ),
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
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    return Hero(
      tag: "${listing.id}",
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 0),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              colorScheme.primary.withOpacity(0.9),
              colorScheme.inversePrimary,
            ],
          ),
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              // color: colorScheme.shadow.withOpacity(0.2),
              blurRadius: 6,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          elevation: 0,
          color: Colors.transparent,
          clipBehavior: Clip.antiAlias,
          child: ListTile(
            title: Text(
              listing.name,
              style: theme.textTheme.titleMedium?.copyWith(color: Colors.white),
            ),
            subtitle: Text("₱ ${listing.priceFixed}"),
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
        ),
      ),
    );
  }
}
