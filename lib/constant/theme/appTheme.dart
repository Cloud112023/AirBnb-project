import 'package:flutter/material.dart';

class TAppTheme {
  TAppTheme._();

  static ThemeData appTheme =
      ThemeData(
        fontFamily: 'Couture',
        brightness: Brightness.dark,
      ).copyWith(
        textTheme: ThemeData.dark().textTheme.apply(
          fontFamily: 'Couture',
          bodyColor: Colors.white,
          displayColor: Colors.white,
        ),
        scaffoldBackgroundColor: Colors.black,
        primaryColor: Colors.black,
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.black,
          foregroundColor: Colors.white,
          iconTheme: IconThemeData(color: Colors.white),
          titleTextStyle: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        colorScheme: ColorScheme.dark(
          surface: Colors.black,
          primary: Colors.white,
          onPrimary: Colors.black,
          secondary: Colors.white,
          onSecondary: Colors.black,
          onSurface: Colors.white,
        ),
        iconTheme: IconThemeData(color: Colors.white),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: Colors.black,
          hintStyle: TextStyle(color: Colors.white70),
          border: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white54),
            borderRadius: BorderRadius.all(Radius.circular(8)),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white54),
            borderRadius: BorderRadius.all(Radius.circular(8)),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white54),
            borderRadius: BorderRadius.all(Radius.circular(8)),
          ),
        ),
      );
}
