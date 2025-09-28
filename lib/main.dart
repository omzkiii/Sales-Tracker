import 'package:flutter/material.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    var lister = ListNotifier();
    return MaterialApp(
      home: Scaffold(
        body: Column(
          children: [
            Expanded(
              child: ListenableBuilder(
                listenable: lister,
                builder: (context, child) {
                  return ListView(
                    children: lister.numbers
                        .map((item) => Text("$item"))
                        .toList(),
                  );
                },
              ),
            ),
            Text("${lister.numbers}"),
            TextButton(
              onPressed: () {
                lister.addToList();
              },
              child: Text("Add"),
            ),
          ],
        ),
      ),
    );
  }
}

class ListNotifier extends ChangeNotifier {
  int _number = 0;
  final List<int> _numbers = [];
  List<int> get numbers => _numbers;

  void addToList() {
    _numbers.add(_number++);
    print(numbers);
    notifyListeners();
  }
}
