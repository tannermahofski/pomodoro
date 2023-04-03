import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pomodoro_timer/helpers/constants/color_constants.dart';

final ThemeData kAppTheme = ThemeData(
  scaffoldBackgroundColor: const Color.fromARGB(255, 246, 246, 246),
  brightness: Brightness.light,
  inputDecorationTheme: InputDecorationTheme(
    prefixIconColor: kVioletBlue,
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: const BorderSide(color: kVioletBlue, width: 2),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
    ),
  ),
  appBarTheme: AppBarTheme(
    centerTitle: false,
    color: Colors.transparent,
    elevation: 0,
    titleTextStyle: GoogleFonts.encodeSans(
      fontSize: 20,
      fontWeight: FontWeight.w600,
      color: kBlackOlive,
    ),
    iconTheme: const IconThemeData(color: kBlackOlive),
  ),
  textTheme: TextTheme(
    headlineMedium: GoogleFonts.encodeSans(
      color: kBlackOlive,
      fontSize: 36,
      fontWeight: FontWeight.w500,
    ),
    headlineSmall: GoogleFonts.encodeSans(
      color: kBlackOlive,
      fontSize: 24,
      fontWeight: FontWeight.w500,
    ),
    titleLarge: GoogleFonts.encodeSans(
      color: kBlackOlive,
      fontSize: 22,
      fontWeight: FontWeight.w600,
    ),
    titleMedium: GoogleFonts.encodeSans(
      color: kBlackOlive,
      fontSize: 16,
      fontWeight: FontWeight.w600,
    ),
    titleSmall: GoogleFonts.encodeSans(
      color: kBlackOlive,
      fontSize: 14,
      fontWeight: FontWeight.w600,
    ),
    labelLarge: GoogleFonts.encodeSans(
      color: kBlackOlive,
      fontSize: 14,
      fontWeight: FontWeight.w600,
    ),
    labelMedium: GoogleFonts.encodeSans(
      color: kBlackOlive,
      fontSize: 12,
      fontWeight: FontWeight.w600,
    ),
    labelSmall: GoogleFonts.encodeSans(
      color: kBlackOlive,
      fontSize: 11,
      fontWeight: FontWeight.w600,
    ),
    bodyLarge: GoogleFonts.encodeSans(
      color: kBlackOlive,
      fontSize: 16,
      fontWeight: FontWeight.w500,
    ),
    bodyMedium: GoogleFonts.encodeSans(
      color: kBlackOlive,
      fontSize: 14,
      fontWeight: FontWeight.w500,
    ),
    bodySmall: GoogleFonts.encodeSans(
      color: kBlackOlive,
      fontSize: 12,
      fontWeight: FontWeight.w500,
    ),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      minimumSize: const Size(0, 50),
      backgroundColor: kVioletBlue,
      shape: const StadiumBorder(),
      textStyle: GoogleFonts.encodeSans(
        fontSize: 20,
        fontWeight: FontWeight.normal,
        color: Colors.white,
      ),
    ),
  ),
  textButtonTheme: TextButtonThemeData(
    style: TextButton.styleFrom(
      textStyle: GoogleFonts.encodeSans(fontSize: 14, color: kVioletBlue),
    ),
  ),
  progressIndicatorTheme: const ProgressIndicatorThemeData(
    color: kVioletBlue,
  ),
  iconTheme: const IconThemeData(color: kBlackOlive),
);
