import 'package:flutter/material.dart';

import '../constants/colors.dart';

ThemeData themeDefault() {
  return ThemeData(
    scaffoldBackgroundColor: Color(0xFFF5F5F5),
    canvasColor: paletteBlue,
    primaryColor: paletteYellow,
    hintColor: paletteYellow,
    textTheme: const TextTheme(
      headlineLarge: TextStyle(
        fontSize: 64,
        fontFamily: 'nexa',
        fontWeight: FontWeight.bold,
        color: paletteYellow,
      ),
      headlineMedium: TextStyle(
        fontSize: 24,
        fontFamily: 'nexa',
        fontWeight: FontWeight.bold,
        color: paletteYellow,
      ),
      headlineSmall: TextStyle(
        fontSize: 16,
        fontFamily: 'nexa',
        fontWeight: FontWeight.bold,
        color: paletteYellow,
      ),
      bodyMedium: TextStyle(
        fontSize: 24,
        fontFamily: 'nexa',
        fontWeight: FontWeight.normal,
        color: paletteYellow,
      ),
      bodySmall: TextStyle(
        fontSize: 16,
        fontFamily: 'nexa',
        fontWeight: FontWeight.normal,
        color: paletteYellow,
      ),
    ),

  );
}
