import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppTheme {
  static const Color primaryColor = Color(0xFF17723D);
  static const Color primaryDarkColor = Color(0xFF034F28);
  static const Color accentColor = Color(0xFF32DFA6);
  static const Color secondaryColor = Color(0xFFdbfae8);

  static ThemeData get themeData {
    return ThemeData(
      primaryColor: primaryColor,
      primaryColorDark: primaryDarkColor,
      hintColor: accentColor,
      scaffoldBackgroundColor: Colors.white,
      appBarTheme: const AppBarTheme(
        color: primaryColor,
        systemOverlayStyle: SystemUiOverlayStyle.light,
      ),
      colorScheme: ColorScheme.fromSwatch().copyWith(
        primary: primaryColor,
        secondary: accentColor,
        tertiary: secondaryColor,
      ),
      buttonTheme: ButtonThemeData(
        buttonColor: primaryColor,
        textTheme: ButtonTextTheme.primary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          foregroundColor: Colors.white,
          backgroundColor: primaryColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ),
      textTheme: const TextTheme(
        displayLarge:
            TextStyle(color: primaryDarkColor, fontWeight: FontWeight.bold),
        displayMedium:
            TextStyle(color: primaryDarkColor, fontWeight: FontWeight.bold),
        displaySmall:
            TextStyle(color: primaryDarkColor, fontWeight: FontWeight.bold),
        headlineMedium:
            TextStyle(color: primaryDarkColor, fontWeight: FontWeight.bold),
        headlineSmall:
            TextStyle(color: primaryDarkColor, fontWeight: FontWeight.bold),
        titleLarge:
            TextStyle(color: primaryDarkColor, fontWeight: FontWeight.bold),
        bodyLarge: TextStyle(color: Colors.black87),
        bodyMedium: TextStyle(color: Colors.black87),
      ),
      inputDecorationTheme: InputDecorationTheme(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: primaryColor),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: accentColor, width: 2),
        ),
        labelStyle: const TextStyle(color: primaryColor),
      ),
    );
  }
}
