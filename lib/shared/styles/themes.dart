import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hexcolor/hexcolor.dart';

ThemeData lightTheme = ThemeData(
  appBarTheme: const AppBarTheme(
    titleSpacing: 20.0,
    backgroundColor: Colors.white,
    elevation: 0.0,
    titleTextStyle: TextStyle(
      color: Colors.black,
      fontSize: 25.0,
      fontWeight: FontWeight.bold,
    ),
    iconTheme: IconThemeData(color: Colors.black, size: 28.0),
    systemOverlayStyle: SystemUiOverlayStyle(
      statusBarColor: Colors.white,
      statusBarIconBrightness: Brightness.dark,
    ),
  ),
  scaffoldBackgroundColor: Colors.white,
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    type: BottomNavigationBarType.fixed,
    selectedItemColor: Colors.brown,
    unselectedItemColor: Colors.grey,
    backgroundColor: Colors.white,
    elevation: 20.0,
  ),
  textTheme: const TextTheme(
    bodyLarge: TextStyle(
      fontSize: 20.0,
      color: Colors.black,
    ),
  ),
  fontFamily: 'Jannah',
  floatingActionButtonTheme:
      FloatingActionButtonThemeData(foregroundColor: Colors.white),
  colorSchemeSeed: Colors.brown,
);
