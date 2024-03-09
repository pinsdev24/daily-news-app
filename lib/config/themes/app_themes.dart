import 'package:flutter/material.dart';

ThemeData theme() {
  return ThemeData(
      scaffoldBackgroundColor: Colors.white,
      appBarTheme: _appBarTheme(),
      useMaterial3: true,
      inputDecorationTheme: _inputDecorationTheme());
}

AppBarTheme _appBarTheme() {
  return const AppBarTheme(
    color: Colors.white,
    elevation: 0,
    centerTitle: true,
    iconTheme: IconThemeData(color: Color(0xFF8B8B8B)),
    titleTextStyle: TextStyle(color: Color(0xFF8B8B8B), fontSize: 18),
  );
}

InputDecorationTheme _inputDecorationTheme() {
  return InputDecorationTheme(
      floatingLabelStyle: const TextStyle(color: Colors.blue),
      iconColor: const Color(0xFF8B8B8B),
      focusedBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: Color(0xFF8B8B8B)),
        borderRadius: BorderRadius.circular(8),
      ),
      border: OutlineInputBorder(
        borderSide: const BorderSide(color: Colors.blue),
        borderRadius: BorderRadius.circular(8),
      ));
}
