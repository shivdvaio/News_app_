import 'package:flutter/material.dart';

final kdarkTheme = ThemeData.dark().copyWith(
    appBarTheme: AppBarTheme(
      textTheme: TextTheme(
        headline6: TextStyle(color: Colors.black, fontSize: 23),
      ),
    ),
    primaryColor: Colors.black,
    brightness: Brightness.dark,
    backgroundColor: const Color(0xFF212121),
    accentColor: Color(0xFF212121),
    accentIconTheme: IconThemeData(color: Colors.black),
    secondaryHeaderColor: Colors.white,
    focusColor: Colors.white);

final klightTheme = ThemeData.light().copyWith(
    appBarTheme: AppBarTheme(
      textTheme: TextTheme(
        headline6: TextStyle(color: Colors.black, fontSize: 23),
      ),
    ),
    primaryColor: Colors.white,
    brightness: Brightness.light,
    backgroundColor: const Color(0xFFE5E5E5),
    accentColor: Color(0xffeeeeee),
    accentIconTheme: IconThemeData(color: Colors.black),
    dividerColor: Colors.black,
    secondaryHeaderColor: Colors.black,
    focusColor: Colors.black);
