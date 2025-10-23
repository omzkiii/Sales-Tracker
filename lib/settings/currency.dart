import 'package:app/db.dart';
import 'package:app/global.dart';
import 'package:flutter/foundation.dart';
import 'package:sqflite/sqflite.dart';

Future<void> changeCurrency(String currency) async {
  Database db = await DB.initDB();
  await db.insert("settings", {
    "key": "currency",
    "val": currency,
  }, conflictAlgorithm: ConflictAlgorithm.replace);
}

ValueNotifier<Currency> currency = ValueNotifier<Currency>(
  Currency(code: 'USD', name: 'US Dollar', symbol: '\$'),
);
Future<void> loadCurrency() async {
  String currCode = await getSetting("currency");
  currency.value = currencies[currCode]!;
}

class Currency {
  final String code;
  final String name;
  final String symbol;

  const Currency({
    required this.code,
    required this.name,
    required this.symbol,
  });
}

final Map<String, Currency> currencies = {
  'USD': const Currency(code: 'USD', name: 'US Dollar', symbol: '\$'),
  'PHP': const Currency(code: 'PHP', name: 'Philippine Peso', symbol: '₱'),
  'EUR': const Currency(code: 'EUR', name: 'Euro', symbol: '€'),
  'JPY': const Currency(code: 'JPY', name: 'Japanese Yen', symbol: '¥'),
  'GBP': const Currency(code: 'GBP', name: 'British Pound', symbol: '£'),
  'KRW': const Currency(code: 'KRW', name: 'South Korean Won', symbol: '₩'),
  'INR': const Currency(code: 'INR', name: 'Indian Rupee', symbol: '₹'),
  'THB': const Currency(code: 'THB', name: 'Thai Baht', symbol: '฿'),
  'IDR': const Currency(code: 'IDR', name: 'Indonesian Rupiah', symbol: 'Rp'),
  'MYR': const Currency(code: 'MYR', name: 'Malaysian Ringgit', symbol: 'RM'),
  'VND': const Currency(code: 'VND', name: 'Vietnamese Dong', symbol: '₫'),
  'AED': const Currency(code: 'AED', name: 'UAE Dirham', symbol: 'د.إ'),
  'SAR': const Currency(code: 'SAR', name: 'Saudi Riyal', symbol: '﷼'),
  'TRY': const Currency(code: 'TRY', name: 'Turkish Lira', symbol: '₺'),
  'RUB': const Currency(code: 'RUB', name: 'Russian Ruble', symbol: '₽'),
  'ZAR': const Currency(code: 'ZAR', name: 'South African Rand', symbol: 'R'),
  'BRL': const Currency(code: 'BRL', name: 'Brazilian Real', symbol: 'R\$'),
  'NGN': const Currency(code: 'NGN', name: 'Nigerian Naira', symbol: '₦'),
  'BDT': const Currency(code: 'BDT', name: 'Bangladeshi Taka', symbol: '৳'),
  'PLN': const Currency(code: 'PLN', name: 'Polish Zloty', symbol: 'zł'),
  'CZK': const Currency(code: 'CZK', name: 'Czech Koruna', symbol: 'Kč'),
  'HUF': const Currency(code: 'HUF', name: 'Hungarian Forint', symbol: 'Ft'),
  'ILS': const Currency(code: 'ILS', name: 'Israeli Shekel', symbol: '₪'),
  'KWD': const Currency(code: 'KWD', name: 'Kuwaiti Dinar', symbol: 'د.ك'),
  'GHS': const Currency(code: 'GHS', name: 'Ghanaian Cedi', symbol: '₵'),
  'MAD': const Currency(code: 'MAD', name: 'Moroccan Dirham', symbol: 'د.م.'),
  'CHF': const Currency(code: 'CHF', name: 'Swiss Franc', symbol: 'Fr'),
  'NOK': const Currency(code: 'NOK', name: 'Norwegian Krone', symbol: 'kr'),
};
