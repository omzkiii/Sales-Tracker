import 'package:app/colors.dart';
import 'package:app/global.dart';
import 'package:app/settings/currency.dart';
import 'package:app/views/form_listing.dart';
import 'package:app/views/listing_operations.dart';
import 'package:app/views/listings.dart';
import 'package:app/views/settings.dart';
import 'package:dynamic_color/dynamic_color.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await loadCurrency();
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
          theme: lightTheme,
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
  int selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    var listingController = ListingNotifier();
    final List<String> pageTitle = ["Listings", "Sold", "Settings"];
    final List<Widget> pages = [
      Listings(listingNotifier: listingController, status: "listed"),
      Listings(listingNotifier: listingController, status: "sold"),
      SettingsPage(),
    ];

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(title: Text(pageTitle[selectedIndex])),
        drawer: NavigationDrawer(
          selectedIndex: selectedIndex,
          onDestinationSelected: (int index) {
            setState(() {
              selectedIndex = index;
              Navigator.pop(context);
            });
          },
          children: [
            NavigationDrawerDestination(
              icon: Icon(Icons.list_alt_sharp),
              label: Text("Listings"),
            ),
            NavigationDrawerDestination(
              icon: Icon(Icons.sell_outlined),
              label: Text("Sold"),
            ),
            NavigationDrawerDestination(
              icon: Icon(Icons.settings),
              label: Text("Settings"),
            ),
          ],
        ),
        body: pages[selectedIndex],

        // appBar: AppBar(
        //   title: TabBar(
        //     tabs: [
        //       Tab(text: "Listed"),
        //       Tab(text: "Sold"),
        //     ],
        //   ),
        // ),
        // body: TabBarView(
        //   children: [
        //     Listings(listingNotifier: listingController, status: "listed"),
        //     Listings(listingNotifier: listingController, status: "sold"),
        //   ],
        // ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
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
