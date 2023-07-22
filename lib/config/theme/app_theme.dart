import 'package:flutter/material.dart';

abstract class AppTheme {
  static ThemeData get light {
    return ThemeData(
        appBarTheme: const AppBarTheme(
          elevation: 0,
          color: Colors.white,
        ),
        scaffoldBackgroundColor: Colors.white,
        primaryColor: colorPrimary,
        splashColor: Colors.transparent,
        fontFamily: 'IBM',
        colorScheme: ColorScheme.fromSwatch().copyWith(secondary: Colors.black),
        inputDecorationTheme: const InputDecorationTheme(
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: colorPrimary, width: 1.0),
          ),
        ),
        textSelectionTheme: const TextSelectionThemeData(
          cursorColor: colorPrimary,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
            style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(colorPrimary),
        )),
        textTheme: const TextTheme(
            headlineLarge: TextStyle(fontSize: 40, color: colorHeader),
            headlineMedium: TextStyle(fontSize: 36, color: colorHeader),
            titleLarge: TextStyle(
                fontSize: 24, color: colorGray, fontWeight: FontWeight.normal),
            titleMedium: TextStyle(
              color: colorGray,
              fontSize: 20,
            ),
            titleSmall: TextStyle(
                fontSize: 18, color: colorGray, fontWeight: FontWeight.normal),
            labelMedium: TextStyle(
              color: colorGray,
              fontSize: 20,fontWeight: FontWeight.w300
            ),
            bodyMedium: TextStyle(fontSize: 16, color: colorDes),
            bodySmall: TextStyle(fontSize: 14, color: colorDes)));
  }
}

const Color colorPrimary = Color(0xff854fff);
const Color colorPrimaryDark = Color(0xff6c2aff);
const Color colorGray = Color(0xff344357);
const Color colorHeader = Color(0xff364a63);
const Color colorDes = Color(0xff526484);
const Color lightGray = Color.fromRGBO(195, 195, 195, 1);
const Color darkGray = Color.fromRGBO(51, 51, 51, 1);
const Color backgroundGray = Color.fromRGBO(239, 239, 239, 1.0);
