import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'colors.dart';

class MyTheme{
  static ThemeData lightTheme = ThemeData(
    scaffoldBackgroundColor: mint,
    textTheme: TextTheme(
      bodySmall: GoogleFonts.elMessiri(
        fontSize: 20,
        color: mint,
        fontWeight: FontWeight.w400,
      ),
      bodyMedium: GoogleFonts.elMessiri(
        fontSize: 25,
        color: mint,
        fontWeight: FontWeight.w700,
      ),
      bodyLarge: GoogleFonts.elMessiri(
        fontSize: 30,
        color: mint,
        fontWeight: FontWeight.bold,
      ),
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      type: BottomNavigationBarType.fixed,
      selectedItemColor: primaryColor,
      unselectedItemColor: Colors.grey,
      backgroundColor: Colors.white,
      showSelectedLabels: false,
      showUnselectedLabels: false,
    ),
  );
  static ThemeData darkTheme = ThemeData(
    colorScheme:ColorScheme(
      brightness: Brightness.dark,
      primary:darkprimary,
      onPrimary: Colors.white,
      secondary:yellow,
      onSecondary: Colors.white,
      error: Colors.red,
      onError: Colors.white,
      background: darkprimary,
      onBackground: mint,
      surface: darkprimary,
      onSurface: Colors.white,
    ) ,
    scaffoldBackgroundColor: Colors.transparent,
    textTheme: TextTheme(
      bodySmall: GoogleFonts.elMessiri(
        fontSize: 20,
        color: Colors.white,
        fontWeight: FontWeight.w400,
      ),
      bodyMedium: GoogleFonts.elMessiri(
        fontSize: 25,
        color:Color(0xffacc1d),
        fontWeight: FontWeight.w700,
      ),
      bodyLarge: GoogleFonts.elMessiri(
        fontSize: 30,
        color: Color(0xffacc1d),
        fontWeight: FontWeight.bold,
      ),
    ),
    appBarTheme: AppBarTheme(
      iconTheme: IconThemeData(color: Colors.white),
      color: Colors.transparent,
      elevation: 0.0,
      centerTitle: true,
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      type: BottomNavigationBarType.shifting,
      selectedItemColor: yellow,
      unselectedItemColor: Colors.white,
      backgroundColor: darkprimary,
    ),

  );
}