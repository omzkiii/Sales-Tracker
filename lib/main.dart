import 'package:app/models/listing.dart';
import 'package:app/views/listings.dart';
import 'package:flutter/material.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    var listenable = ListingNotifier();
    return MaterialApp(
      home: Scaffold(
        body: Listings(),

        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            Listing listing = Listing(
              name: "foo",
              price: 99.0,
              desc: "listed item",
            );
            listenable.addToList(listing);
          },
          child: Icon(Icons.add),
        ),
        bottomNavigationBar: BottomAppBar(
          elevation: 0.0,
          child: Row(
            children: [
              IconButton(
                tooltip: 'Open navigation menu',
                icon: const Icon(Icons.menu),
                onPressed: () {},
              ),
              Spacer(),
              IconButton(
                tooltip: 'Search',
                icon: const Icon(Icons.search),
                onPressed: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}
