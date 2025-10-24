import 'package:app/models/listing.dart';
import 'package:app/settings/currency.dart';
import 'package:app/views/form_listing.dart';
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
              if (!listingNotifier.list.any((elem) => elem.status == status)) {
                return Expanded(
                  child: Center(
                    child: Text(
                      "No $status listing",
                      style: TextStyle(fontStyle: FontStyle.italic),
                    ),
                  ),
                );
              }
              return Expanded(
                child: ListView(
                  children: listingNotifier.list
                      .where((elem) => elem.status == status)
                      .map(
                        (elem) => Container(
                          padding: EdgeInsets.symmetric(
                            vertical: 0,
                            horizontal: 10,
                          ),
                          child: ListingCard(
                            listing: elem,
                            listingNotifier: listingNotifier,
                            status: status,
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

      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) =>
                  FormListing(isNew: true, listingNotifier: listingNotifier),
            ),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}

class ListingCard extends StatelessWidget {
  final Listing listing;
  final ListingNotifier listingNotifier;
  final String status;
  const ListingCard({
    super.key,

    required this.listing,
    required this.listingNotifier,
    required this.status,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    return Hero(
      tag: "${listing.id}",
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        elevation: 3,
        borderOnForeground: false,
        color: status == "sold" ? colorScheme.primary : colorScheme.tertiary,
        clipBehavior: Clip.antiAlias,
        child: ListTile(
          title: Text(
            listing.name,
            style: theme.textTheme.titleMedium?.copyWith(
              color: status == "sold"
                  ? colorScheme.onPrimary
                  : colorScheme.onTertiary,
            ),
          ),
          subtitle: ValueListenableBuilder(
            valueListenable: currency,
            builder: (context, value, child) {
              return Text(
                "${currency.value.symbol} ${listing.priceFixed}",
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: status == "sold"
                      ? colorScheme.onPrimary
                      : colorScheme.onTertiary,
                ),
              );
            },
          ),
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
    );
  }
}
