import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pomodoro_timer/helpers/constants/color_constants.dart';

final ThemeData kAppTheme = ThemeData(
  textTheme: TextTheme(
    //Note: This is for screen titles (Ex. 'Welcome')
    displayMedium: GoogleFonts.encodeSans(
      fontSize: 36,
      fontWeight: FontWeight.bold,
      color: kBlackOlive,
    ),
    //Note: This will be used as hint text
    bodySmall: GoogleFonts.encodeSans(
      fontSize: 15,
      fontWeight: FontWeight.normal,
      color: kBlackOlive.withOpacity(0.8),
    ),
    //Note: This will be used as actual textfield text
    bodyMedium: GoogleFonts.encodeSans(
      fontSize: 15,
      fontWeight: FontWeight.normal,
      color: kBlackOlive,
    ),
    //Note: This will be used for errors
    headlineSmall: GoogleFonts.encodeSans(
      fontSize: 12,
      fontWeight: FontWeight.normal,
      color: kErrorColor,
    ),
    headlineMedium: GoogleFonts.encodeSans(
      fontSize: 18,
      fontWeight: FontWeight.normal,
      color: kBlackOlive,
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
    color: kBlackOlive,
  ),
);
