import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppWidget {
  static TextStyle titleNameLight() {
    return GoogleFonts.aboreto(
      color: Colors.black,
      fontSize: 36,
      fontWeight: FontWeight.w900,
    );
  }

  static TextStyle largeLight() {
    return GoogleFonts.lato(
      color: Colors.black,
      fontSize: 30,
      fontWeight: FontWeight.w900,
    );
  }

  static TextStyle infoLight() {
    return GoogleFonts.lato(
      color: Colors.black.withOpacity(0.5),
      fontSize: 15,
      fontWeight: FontWeight.w900,
    );
  }

  static TextStyle platesLight() {
    return GoogleFonts.lato(
      color: Colors.black,
      fontSize: 20,
      fontWeight: FontWeight.w900,
    );
  }

  static TextStyle pagesLight() {
    return GoogleFonts.lato(
      color: Colors.black,
      fontSize: 27,
      fontWeight: FontWeight.w900,
    );
  }

  static TextStyle titleNameDark() {
    return GoogleFonts.aboreto(
      color: Colors.white,
      fontSize: 36,
      fontWeight: FontWeight.w900,
    );
  }

  static TextStyle largeDark() {
    return GoogleFonts.lato(
      color: Colors.white,
      fontSize: 30,
      fontWeight: FontWeight.w900,
    );
  }

  static TextStyle infoDark() {
    return GoogleFonts.lato(
      color: Colors.white.withOpacity(0.5),
      fontSize: 15,
      fontWeight: FontWeight.w900,
    );
  }

  static TextStyle platesDark() {
    return GoogleFonts.lato(
      color: Colors.white,
      fontSize: 20,
      fontWeight: FontWeight.w900,
    );
  }

  static TextStyle pagesDark() {
    return GoogleFonts.lato(
      color: Colors.white,
      fontSize: 27,
      fontWeight: FontWeight.w900,
    );
  }
}
