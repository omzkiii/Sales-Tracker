import 'package:flutter/material.dart';

/// Mix two colors evenly in HSL space.
Color _mix(Color a, Color b, [double amount = 0.5]) {
  final hslA = HSLColor.fromColor(a);
  final hslB = HSLColor.fromColor(b);

  final mixed = HSLColor.fromAHSL(
    (hslA.alpha + hslB.alpha) / 2,
    (hslA.hue + hslB.hue) / 2,
    (hslA.saturation + hslB.saturation) / 2,
    (hslA.lightness + hslB.lightness) / 2,
  );

  return mixed.toColor();
}

ThemeData generateMultiSeedTheme({
  required Color seed1,
  required Color seed2,
  required Color seed3,
  Brightness brightness = Brightness.light,
}) {
  final blended = _mix(_mix(seed1, seed2, 0.5), seed3, 0.5);

  final base = ColorScheme.fromSeed(seedColor: blended, brightness: brightness);

  final customScheme = base.copyWith(secondary: seed2, tertiary: seed3);

  return ThemeData(colorScheme: customScheme, useMaterial3: true);
}
