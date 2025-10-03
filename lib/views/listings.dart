import 'package:app/controllers/listing.dart';
import 'package:app/models/listing.dart';
import 'package:flutter/material.dart';

class Listings extends StatelessWidget {
  const Listings({super.key});

  @override
  Widget build(BuildContext context) {
    var listenable = ListNotifier();
    return Scaffold(
      body: Column(
        children: [
          ListenableBuilder(
            listenable: listenable,
            builder: (context, child) {
              listenable.loadList();
              return SizedBox(
                height: 500.0,
                child: ListView(
                  children: listenable.list
                      .map((elem) => Text(elem.name))
                      .toList(),
                ),
              );
            },
          ),
        ],
      ),
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
            IconButton(
              tooltip: 'Favorite',
              icon: const Icon(Icons.favorite),
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }
}

class ListNotifier extends ChangeNotifier {
  List<Listing> _list = [];
  List<Listing> get list => _list;

  void addToList(Listing listing) async {
    insertListing(listing);
    await loadList();
  }

  Future<void> loadList() async {
    _list = await listings();
    notifyListeners();
  }
}
