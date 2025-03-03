import 'package:e_commerce/core/theme/color_pallet.dart';
import 'package:flutter/material.dart';

class AppTheme {
  static final _border = OutlineInputBorder(
    borderRadius: BorderRadius.circular(10),
    borderSide: BorderSide(width: 3, color: Colors.white60),
  );

  ThemeData darkThemeMode = ThemeData.dark().copyWith(
    textTheme: TextTheme(headlineLarge: TextStyle()),
    inputDecorationTheme: InputDecorationTheme(
      contentPadding: EdgeInsets.all(20),
      focusedBorder: _border.copyWith(
          borderSide: BorderSide(color: Colors.pinkAccent.shade200, width: 3)),
      enabledBorder: _border,
    ),
    appBarTheme: AppBarTheme(backgroundColor: ColorPallet.backgroundColor),
    scaffoldBackgroundColor: ColorPallet.backgroundColor,
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: ColorPallet.backgroundColor),
    cardTheme: CardTheme(color: Colors.white12),
  );
}
