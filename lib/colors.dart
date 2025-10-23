import 'package:flutter/material.dart';

class AppColors {
  static const lapisLazuli = Color(0xFF05668D);
  static const teal = Color(0xFF028090);
  static const persianGreen = Color(0xFF00A896);
  static const jungleGreen = Color(0xFF01B698);
  static const mint = Color(0xFF02C39A);
  static const mint2 = Color(0xFF3ECFA3);
  static const celadon = Color(0xFF79DBAC);
  static const cream = Color(0xFFF0F3BD);
}

ThemeData lightTheme = ThemeData(
  useMaterial3: true,
  brightness: Brightness.light,
  colorScheme: const ColorScheme(
    brightness: Brightness.light,
    primary: AppColors.teal,
    onPrimary: Colors.white,
    secondary: AppColors.mint,
    onSecondary: Colors.white,
    tertiary: AppColors.persianGreen,
    onTertiary: Colors.white,
    error: Colors.redAccent,
    onError: Colors.white,
    surface: Colors.white,
    onSurface: Colors.black87,
    background: AppColors.celadon,
    onBackground: Colors.black87,
  ),
  scaffoldBackgroundColor: Colors.white,
  appBarTheme: const AppBarTheme(
    backgroundColor: AppColors.mint,
    foregroundColor: Colors.white,
  ),
  floatingActionButtonTheme: const FloatingActionButtonThemeData(
    backgroundColor: AppColors.mint,
    foregroundColor: Colors.white,
  ),
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    backgroundColor: AppColors.celadon,
    selectedItemColor: AppColors.teal,
    unselectedItemColor: Colors.grey,
  ),
);

ThemeData darkTheme = ThemeData(
  useMaterial3: true,
  brightness: Brightness.dark,
  colorScheme: const ColorScheme(
    brightness: Brightness.dark,
    primary: AppColors.mint,
    onPrimary: Colors.black,
    secondary: AppColors.jungleGreen,
    onSecondary: Colors.black,
    tertiary: AppColors.persianGreen,
    onTertiary: Colors.black,
    error: Colors.redAccent,
    onError: Colors.black,
    surface: AppColors.lapisLazuli,
    onSurface: Colors.white,
    background: AppColors.teal,
    onBackground: Colors.white,
  ),
  scaffoldBackgroundColor: AppColors.lapisLazuli,
  appBarTheme: const AppBarTheme(
    backgroundColor: AppColors.teal,
    foregroundColor: Colors.white,
  ),
  floatingActionButtonTheme: const FloatingActionButtonThemeData(
    backgroundColor: AppColors.mint2,
    foregroundColor: Colors.black,
  ),
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    backgroundColor: AppColors.teal,
    selectedItemColor: AppColors.mint,
    unselectedItemColor: Colors.white70,
  ),
);
