import 'package:app/views/form_listing.dart';
import 'package:app/views/listing_operations.dart';
import 'package:app/views/listings.dart';
import 'package:dynamic_color/dynamic_color.dart';
import 'package:flutter/material.dart';

final _defaultSeedColor = Colors.teal;
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
        final lightColorScheme =
            lightDynamic?.harmonized() ??
            ColorScheme.fromSeed(
              seedColor: _defaultSeedColor,
              brightness: Brightness.light,
            );
        final darkColorScheme =
            darkDynamic?.harmonized() ??
            ColorScheme.fromSeed(
              seedColor: _defaultSeedColor,
              brightness: Brightness.dark,
            );

        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Transak',
          themeMode: ThemeMode.system,
          theme: ThemeData(useMaterial3: true, colorScheme: lightColorScheme),
          darkTheme: ThemeData(
            useMaterial3: true,
            colorScheme: darkColorScheme,
          ),
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
