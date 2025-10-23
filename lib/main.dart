import 'package:app/colors.dart';
import 'package:app/views/form_listing.dart';
import 'package:app/views/listing_operations.dart';
import 'package:app/views/listings.dart';
import 'package:dynamic_color/dynamic_color.dart';
import 'package:flutter/material.dart';

Color mix(Color a, Color b, double amount) {
  return Color.lerp(a, b, amount)!;
}

final base2 = Colors.lightBlueAccent;
final base1 = Colors.deepOrangeAccent;
final base3 = Colors.lightGreenAccent;

final blendedSeed = mix(mix(base1, base2, 0.5), base3, 0.5);
void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(RootApp());
}

class RootApp extends StatelessWidget {
  const RootApp({super.key});

  @override
  Widget build(BuildContext context) {
    return DynamicColorBuilder(
      builder: (ColorScheme? lightDynamic, ColorScheme? darkDynamic) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Transak',
          themeMode: ThemeMode.system,
          theme: generateMultiSeedTheme(
            seed1: Colors.indigo,
            seed2: Colors.amber,
            seed3: Colors.teal,
          ),
          // theme: ThemeData(
          //   colorScheme: ColorScheme.fromSeed(
          //     seedColor: blendedSeed,
          //     brightness: Brightness.light,
          //   ),
          //   useMaterial3: true,
          // ),
          // darkTheme: ThemeData(
          //   colorScheme: ColorScheme.fromSeed(
          //     seedColor: blendedSeed,
          //     brightness: Brightness.light,
          //   ),
          //   useMaterial3: true,
          // ),
          home: const App(),
        );
      },
    );
  }
}

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  Widget build(BuildContext context) {
    var listingController = ListingNotifier();
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: TabBar(
            tabs: [
              Tab(text: "Listed"),
              Tab(text: "Sold"),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            Listings(listingNotifier: listingController, status: "listed"),
            Listings(listingNotifier: listingController, status: "sold"),
          ],
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => FormListing(
                  isNew: true,
                  listingNotifier: listingController,
                ),
              ),
            );
          },
          child: Icon(Icons.add),
        ),
      ),
    );
  }
}
