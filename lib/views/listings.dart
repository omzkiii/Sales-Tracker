import 'package:app/controllers/listing.dart';
import 'package:app/models/listing.dart';
import 'package:flutter/material.dart';

class Listings extends StatelessWidget {
  const Listings({super.key});

  @override
  Widget build(BuildContext context) {
    var listenable = ListNotifier();
    return Column(
      children: [
        ListenableBuilder(
          listenable: listenable,
          builder: (context, child) {
            listenable.loadList();
            return Container(
              height: 500.0,
              color: Colors.green,
              child: ListView(
                children: listenable.list
                    .map((item) => Text(item.name))
                    .toList(),
              ),
            );
          },
        ),

        ElevatedButton(
          onPressed: () {
            Listing listing = Listing(name: "foo", price: 10, desc: "for sale");
            listenable.addToList(listing);
          },
          child: Text("Add to list"),
        ),
      ],
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
