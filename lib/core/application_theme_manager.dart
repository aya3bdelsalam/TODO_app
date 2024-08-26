import 'package:flutter/material.dart';

class ApplicationThemeManager {
  static const Color primaryColor = Color(0xFF5D9CEC);
  static const Color primaryDarkColor = Color(0xFF060E1E);

  static ThemeData lightThemeData = ThemeData(
      primaryColor: primaryColor,
      scaffoldBackgroundColor: const Color(0xFFDFECDB),
      appBarTheme: const AppBarTheme(
          toolbarHeight: 140,
          centerTitle: true,
          backgroundColor: Colors.transparent,
          titleTextStyle: TextStyle(
            fontFamily: "poppins",
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
          iconTheme: IconThemeData(color: Colors.white)),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        selectedItemColor: primaryColor,
        selectedIconTheme: IconThemeData(
          color: primaryColor,
          size: 35,
        ),
        showSelectedLabels: false,
        showUnselectedLabels: false,
        unselectedIconTheme: IconThemeData(
          size: 28,
        ),
      ),
      textTheme: const TextTheme(
          titleLarge: TextStyle(
            fontFamily: "poppins",
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
          bodyLarge: TextStyle(
            fontFamily: "poppins",
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
          bodyMedium: TextStyle(
            fontFamily: "poppins",
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: primaryColor,
          ),
          bodySmall: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w400,
            fontFamily: "Poppins",
            color: Colors.white,
          ),
          displayLarge: TextStyle(
            fontFamily: "poppins",
            fontSize: 18,
            fontWeight: FontWeight.normal,
            color: Colors.black,
          ),
          displaySmall: TextStyle(
            fontFamily: "poppins",
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: Colors.black,
          )));
  static ThemeData darkThemeData = ThemeData(
      primaryColor: primaryDarkColor,
      primaryColorLight: primaryColor,
      scaffoldBackgroundColor: primaryDarkColor,
      appBarTheme: const AppBarTheme(
          iconTheme: IconThemeData(color: Colors.white),
          backgroundColor: Colors.transparent,
          titleTextStyle: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            fontFamily: "Poppins",
            color: Colors.white,
          )),
      textTheme: const TextTheme(
        titleLarge: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.bold,
            fontFamily: "Poppins",
            color: Colors.white),
        bodyLarge: TextStyle(
          fontSize: 25,
          fontWeight: FontWeight.bold,
          fontFamily: "Poppins",
          color: Colors.white,
        ),
        bodyMedium: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w400,
          fontFamily: "Poppins",
          color: Colors.white,
        ),
        bodySmall: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w400,
          fontFamily: "Poppins",
          color: Colors.white,
        ),
        displaySmall: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w400,
          fontFamily: "Poppins",
          color: Colors.white,
        ),
        displayMedium: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          fontFamily: "Poppins",
          color: Colors.white,
        ),
      ),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        // backgroundColor: Colors.white
        showSelectedLabels: true,
        showUnselectedLabels: false,
        selectedLabelStyle: TextStyle(
          color: primaryColor,
          fontSize: 18,
          fontFamily: "Poppins",
        ),
        selectedIconTheme: IconThemeData(
          size: 35,
          color: primaryColor,
        ),
        unselectedIconTheme: IconThemeData(
          size: 30,
          color: Color(0xffc8c9cb),
        ),
      ));
}
