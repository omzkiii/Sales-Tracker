import 'package:app/controllers/listing.dart';
import 'package:app/models/listing.dart';
import 'package:flutter/material.dart';
import 'db.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    final fieldText = TextEditingController();
    final listenable = Lister();
    return MaterialApp(
      home: Scaffold(
        body: Column(
          children: [
            Container(
              padding: EdgeInsets.all(100),
              child: TextField(
                controller: fieldText,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "Input",
                ),
              ),
            ),
            ListenableBuilder(
              listenable: listenable,
              builder: (context, child) {
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
              onPressed: () async {
                if (fieldText.text.isNotEmpty) {
                  // listenable.addToList(fieldText.text);
                  Listing listing = Listing(
                    name: fieldText.text,
                    price: 10.10,
                    desc: "listed item",
                  );
                  listenable.addToList(listing);
                  print("Added to listing");
                  fieldText.clear();
                }
              },
              child: Text("Add Item"),
            ),
          ],
        ),
      ),
    );
  }
}

class Lister extends ChangeNotifier {
  List<Listing> _list = [];
  List<Listing> get list => _list;
  void addToList(Listing listing) async {
    print(listing);
    insertListing(listing);
    await loadList();
    notifyListeners();
  }

  Future<void> loadList() async {
    _list = await listings();
  }
}
