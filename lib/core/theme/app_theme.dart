import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart'; // 1. Importa a biblioteca de fontes

class AppTheme {
  AppTheme._();

  static ThemeData get lightTheme {
    return ThemeData(
      primarySwatch: Colors.red,
      scaffoldBackgroundColor: const Color(0xFFF5F5F5),
      textTheme: GoogleFonts.poppinsTextTheme(),
    );
  }
}
