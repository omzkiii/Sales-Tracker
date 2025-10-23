import 'package:app/settings/currency.dart';
import 'package:flutter/material.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  String? _selectedCurrency;
  bool _darkMode = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ValueListenableBuilder(
        valueListenable: currency,
        builder: (context, value, child) {
          return ListView(
            children: [
              ListTile(
                leading: const Icon(Icons.currency_exchange),
                title: const Text("Currency"),
                trailing: DropdownButton<Currency>(
                  focusColor: Colors.transparent,
                  value: currency.value,
                  onChanged: (Currency? newCurrency) {
                    if (newCurrency != null) {
                      currency.value = newCurrency;
                      // saveCurrency(newCode);
                    }
                  },
                  items: currencies.keys.map((code) {
                    final name = currencies[code]!.name;
                    final symbol = currencies[code]!.symbol;
                    return DropdownMenuItem<Currency>(
                      value: currencies[code],
                      child: Text("$name ($symbol)"),
                    );
                  }).toList(),
                ),
              ),
              // SwitchListTile(
              //   title: const Text("Dark Mode"),
              //   secondary: const Icon(Icons.dark_mode),
              //   value: _darkMode,
              //   onChanged: (bool value) {
              //     setState(() => _darkMode = value);
              //     // implement your theme toggle logic here
              //   },
              // ),
            ],
          );
        },
      ),
    );
  }
}
