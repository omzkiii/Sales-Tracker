import 'package:flutter/material.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    List<String> list = ["item 1", "item 2", "item 3"];
    final fieldText = TextEditingController();
    final listenable = Lister();
    return MaterialApp(
      home: Scaffold(
        body: Column(
          children: [
            Container(
              padding: EdgeInsets.only(top: 100),
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
                        .map((item) => Text(item))
                        .toList(),
                  ),
                );
              },
            ),
            ElevatedButton(
              onPressed: () {
                if (fieldText.text.isNotEmpty) {
                  listenable.addToList(fieldText.text);
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
  List<String> _list = [];
  List<String> get list => _list;

  void addToList(String text) {
    print(text);
    _list.add(text);
    notifyListeners();
  }
}
