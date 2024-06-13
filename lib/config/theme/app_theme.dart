import 'package:flutter/material.dart';

abstract class AppTheme {
  static ThemeData get light {
    return ThemeData(
        appBarTheme: const AppBarTheme(
          elevation: 0,
        ),
        scaffoldBackgroundColor: Colors.white,
        primaryColor: AppColor.colorPrimary,
        splashColor: Colors.transparent,
        fontFamily: 'IBM',
        colorScheme: ColorScheme.fromSwatch().copyWith(secondary: Colors.black),
        inputDecorationTheme: InputDecorationTheme(
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: AppColor.colorPrimary, width: 1.0),
          ),
        ),
        textSelectionTheme: TextSelectionThemeData(
          cursorColor: AppColor.colorPrimary,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
            style: ButtonStyle(
                shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                )),
                padding: const WidgetStatePropertyAll(EdgeInsets.all(6)),
                textStyle: const WidgetStatePropertyAll(
                  TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.normal),
                ),
                backgroundColor: WidgetStateProperty.all(AppColor.colorPrimary),
                foregroundColor: WidgetStatePropertyAll(AppColor.white))),
        textTheme: TextTheme(
            headlineLarge: TextStyle(fontSize: 40, color: AppColor.colorHeader, fontWeight: FontWeight.w600),
            headlineMedium:
                TextStyle(fontSize: 36, color: AppColor.colorHeader),
            titleLarge: TextStyle(
                fontSize: 24,
                color: AppColor.colorGray,
                fontWeight: FontWeight.normal),
            titleMedium: TextStyle(
              color: AppColor.colorGray,
              fontSize: 20,
            ),
            titleSmall: TextStyle(
                fontSize: 18,
                color: AppColor.colorGray,
                fontWeight: FontWeight.normal),
            labelMedium: TextStyle(
                color: AppColor.colorGray,
                fontSize: 20,
                fontWeight: FontWeight.w300),
            bodyMedium: TextStyle(fontSize: 16, color: AppColor.colorDes),
            bodySmall: TextStyle(fontSize: 14, color: AppColor.colorDes)));
  }
}

class AppColor {
  static Color colorPrimary = const Color(0xff4885ED);
  static Color colorPrimary300 = const Color(0x33004792);
  static Color colorPrimaryDark = const Color(0xff004792);
  static Color colorGray = const Color(0xff344357);
  static Color colorHeader = const Color(0xff364a63);
  static Color colorDes = const Color(0xff526484);
  static Color lightGray = const Color.fromRGBO(195, 195, 195, 1);
  static Color darkGray = const Color.fromRGBO(51, 51, 51, 1);
  static Color backgroundGray = const Color.fromRGBO(239, 239, 239, 1.0);
  static Color colorPurple = const Color(0xffbb86fc);
  static Color btnBlue = const Color(0xff3D71C9);
  static Color white = Colors.white;
  static Color errorRed = const Color(0xffED756B);
  static Color txtPurple = const Color(0xff7A3FFF);
  static Color notifyRed = const Color(0xffE85347);
  static Color yellow = const Color(0xffF4BD0F);
}
