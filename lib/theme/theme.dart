import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
//=============== Drak Theme ===================================================
  static final darktheme = ThemeData(
      useMaterial3: true,
      scaffoldBackgroundColor: const Color(0xff0b141a),
      primaryColor: const Color(0xff21c063),
      hoverColor: const Color(0xff103529),
      cardColor: const Color(0xffd9fdd3),
      unselectedWidgetColor: Colors.white,
      navigationBarTheme: NavigationBarThemeData(
          elevation: 0,
          backgroundColor: const Color(0xff0b141a),
          indicatorColor: const Color(0xff103529),
          iconTheme: const MaterialStatePropertyAll(
            IconThemeData(size: 25, color: Color(0xffd9fdd3)),
          ),
          labelTextStyle: MaterialStatePropertyAll(
            GoogleFonts.roboto(
              fontWeight: FontWeight.bold,
              fontSize: 12,
              color: Colors.white,
            ),
          )),
      appBarTheme: AppBarTheme(
        iconTheme: const IconThemeData(color: Colors.white, size: 25),
        backgroundColor: const Color(0xff0b141a),
        //-------------------- App Bar Text titel ------------------------------------
        titleTextStyle: GoogleFonts.roboto(
          fontSize: 22,
          fontWeight: FontWeight.bold,
          color: const Color(0xff21c063),
        ),
      ),
      listTileTheme: ListTileThemeData(
          iconColor: Colors.white,
          textColor: Colors.white,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          titleTextStyle: GoogleFonts.roboto(
            fontWeight: FontWeight.w500,
            fontSize: 14,
            color: Colors.white,
          ),
          contentPadding: const EdgeInsets.symmetric(horizontal: 3)),
      iconTheme: const IconThemeData(color: Colors.white),
      textTheme: TextTheme(
        bodyMedium: GoogleFonts.roboto(
          fontWeight: FontWeight.w600,
          fontSize: 14,
          color: const Color(0xff21c063),
        ),
        titleLarge: GoogleFonts.roboto(
          fontWeight: FontWeight.w600,
          fontSize: 16,
          color: Colors.white,
        ),
        titleMedium: GoogleFonts.roboto(
          fontWeight: FontWeight.w400,
          fontSize: 14,
          color: Colors.white,
        ),
        titleSmall: GoogleFonts.roboto(
          fontWeight: FontWeight.w400,
          fontSize: 12,
          color: Colors.white,
        ),
      ));
//============== Light Theme ===================================================
  static final lighttheme = ThemeData(
    scaffoldBackgroundColor: const Color(0xffffffff),
    primaryColor: const Color(0xff1daa61),
    hoverColor: const Color(0xffd9fdd3),
    cardColor: const Color(0xff15603e),
    unselectedWidgetColor: Colors.black,
    navigationBarTheme: NavigationBarThemeData(
      elevation: 0,
      backgroundColor: const Color(0xffffffff),
      indicatorColor: const Color(0xffd9fdd3),
      iconTheme: const MaterialStatePropertyAll(
          IconThemeData(size: 25, color: Color(0xff15603e))),
      labelTextStyle: MaterialStatePropertyAll(
        GoogleFonts.roboto(
          fontWeight: FontWeight.bold,
          fontSize: 12,
          color: Colors.black,
        ),
      ),
    ),
    appBarTheme: AppBarTheme(
      iconTheme: const IconThemeData(color: Colors.black, size: 25),
      backgroundColor: const Color(0xffffffff),
      titleTextStyle: GoogleFonts.roboto(
        fontSize: 22,
        fontStyle: FontStyle.normal,
        fontWeight: FontWeight.bold,
        color: const Color(0xff1daa61),
      ),
    ),
    listTileTheme: ListTileThemeData(
        iconColor: Colors.black,
        textColor: Colors.black,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        titleTextStyle: GoogleFonts.roboto(
          fontWeight: FontWeight.w500,
          fontSize: 14,
          color: Colors.black,
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 3)),
    iconTheme: const IconThemeData(color: Colors.black),
    textTheme: TextTheme(
      bodyMedium: GoogleFonts.roboto(
        fontWeight: FontWeight.w600,
        fontSize: 14,
        color: const Color(0xff1daa61),
      ),
      titleLarge: GoogleFonts.roboto(
        fontWeight: FontWeight.w600,
        fontSize: 16,
        color: Colors.black,
      ),
      titleMedium: GoogleFonts.roboto(
        fontWeight: FontWeight.w400,
        fontSize: 14,
        color: Colors.black,
      ),
      titleSmall: GoogleFonts.roboto(
        fontWeight: FontWeight.w400,
        fontSize: 12,
        color: Colors.black,
      ),
    ),
  );
}
