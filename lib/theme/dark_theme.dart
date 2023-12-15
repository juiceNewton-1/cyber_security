import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cyber_security/theme/custom_colors.dart';

class DarkTheme {
    static const primary = Color(0xFF373747);
  static const onPrimary = Colors.white;
  static const secondary = Color(0xFFEBEBEB);
  static const onSecondary = Color(0xFF939393);
  static const error = Colors.red;
  static const onError = Colors.white;
  static const background = Color(0xFF0C0800);
  static const onBackground = Colors.white;
  static const surface = Color(0xFFBFBFBF);
  static const onSurface = Colors.white;

  static final get = ThemeData(
    scaffoldBackgroundColor: background,
    appBarTheme: AppBarTheme(
      centerTitle: true,
      backgroundColor: Colors.transparent,
      elevation: 0,
      titleTextStyle: GoogleFonts.inter(
          fontWeight: FontWeight.w600, fontSize: 20.0, color: onBackground),
    ),
    inputDecorationTheme: InputDecorationTheme(
      hintStyle: GoogleFonts.inter(
        fontWeight: FontWeight.w400,
        fontSize: 12.0,
        color: onSecondary,
      ),
    ),
    textTheme: TextTheme(
        displayLarge: GoogleFonts.inter(
          fontWeight: FontWeight.w600,
          fontSize: 20.0,
        ),
        displayMedium: GoogleFonts.inter(
          fontWeight: FontWeight.w600,
          fontSize: 20.0,
        ),
        displaySmall: GoogleFonts.inter(
          fontWeight: FontWeight.w500,
          fontSize: 16.0,
        ),
        titleLarge: GoogleFonts.inter(
          fontWeight: FontWeight.w600,
          fontSize: 20.0,
        ),
        titleMedium: GoogleFonts.inter(
          fontWeight: FontWeight.w400,
          fontSize: 20.0,
        ),
        titleSmall: GoogleFonts.inter(
          fontWeight: FontWeight.w600,
          fontSize: 12.0,
        ),
        bodyLarge: GoogleFonts.inter(
          fontSize: 16,
          fontWeight: FontWeight.w300,
        ),
        bodyMedium: GoogleFonts.inter(
          fontSize: 12,
          fontWeight: FontWeight.w700,
        ),
        bodySmall: GoogleFonts.inter(
          fontSize: 10,
          fontWeight: FontWeight.w700,
        ),
        labelMedium: GoogleFonts.inter(
          fontWeight: FontWeight.w400,
          fontSize: 12.0,
        ),
        labelLarge: GoogleFonts.inter(
          fontWeight: FontWeight.w700,
          fontSize: 20.0,
        )).apply(
      bodyColor: onBackground,
      displayColor: onBackground,
    ),
    colorScheme: const ColorScheme(
      brightness: Brightness.dark,
      primary: primary,
      onPrimary: onPrimary,
      secondary: secondary,
      onSecondary: onSecondary,
      error: error,
      onError: onError,
      background: background,
      onBackground: onBackground,
      surface: surface,
      onSurface: onSurface,
    ),
    extensions: [CustomColors.customColors],
  );
}