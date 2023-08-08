import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:x_rent/constants/color_contants.dart';
import 'package:x_rent/constants/strings.dart';

class MyTheme {
  static var darkTheme = ThemeData(
    brightness: Brightness.dark,
    primaryColor: primaryDarkColor,
    scaffoldBackgroundColor: backColor,
    dialogBackgroundColor: primaryDarkColor,
    fontFamily: Strings.fontName,
    bottomSheetTheme:
        const BottomSheetThemeData(backgroundColor: primaryDarkColor),
    appBarTheme:
        const AppBarTheme(backgroundColor: primaryDarkColor, elevation: 0),
    inputDecorationTheme: InputDecorationTheme(
      isDense: true,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(6),
        borderSide: const BorderSide(color: secondaryDarkColor, width: 1),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(6),
        borderSide: const BorderSide(color: secondaryDarkColor, width: 1),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(6),
        borderSide: const BorderSide(color: secondaryDarkColor, width: 1),
      ),
      fillColor: texformfieldColor,
      filled: true,
      focusColor: secondaryDarkColor,
    ),
    textSelectionTheme: const TextSelectionThemeData(
      cursorColor: secondaryDarkColor,
      selectionColor: secondaryDarkColor,
      selectionHandleColor: secondaryDarkColor,
    ),
    colorScheme: const ColorScheme.dark().copyWith(
      secondary: secondaryDarkColor,
      tertiary: redDarkColor,
      background: Colors.white,
    ),
  );
  static const Color primaryColor = primaryDarkColor;
}

TextStyle displaySmallThinWhite = GoogleFonts.getFont(
  Strings.fontName, // Use the Strings class to get the font family
  fontSize: 12,
  fontWeight: FontWeight.w300,
  color: Colors.white,
);

TextStyle bodyText = GoogleFonts.getFont(
  Strings.fontName,
  fontSize: 12,
  fontWeight: FontWeight.w500,
  color: Colors.black,
);
TextStyle displayTitle = GoogleFonts.getFont(
  Strings.fontName,
  fontSize: 20,
  fontWeight: FontWeight.bold,
  color: Colors.black,
);
TextStyle buttonText = GoogleFonts.getFont(
  Strings.fontName,
  fontSize: 12,
  fontWeight: FontWeight.bold,
  color: primaryDarkColor,
);
TextStyle displaySmallWhite = GoogleFonts.getFont(
  Strings.fontName,
  fontSize: 12,
  fontWeight: FontWeight.w500,
  color: Colors.white,
);
TextStyle displaySmallBoldWhite = GoogleFonts.getFont(
  Strings.fontName,
  fontSize: 14,
  fontWeight: FontWeight.bold,
  color: Colors.white,
);
TextStyle displaySmallBoldLightGrey = GoogleFonts.getFont(
  Strings.fontName,
  fontSize: 10,
  fontWeight: FontWeight.bold,
  color: Colors.black.withOpacity(0.4),
);
TextStyle displaySmallerLightGrey = GoogleFonts.getFont(
  Strings.fontName,
  fontSize: 13,
  fontWeight: FontWeight.w500,
  color: Colors.black.withOpacity(0.4),
);
TextStyle displayBigBoldWhite = GoogleFonts.getFont(
  Strings.fontName,
  fontSize: 25,
  fontWeight: FontWeight.bold,
  color: Colors.white,
);
TextStyle displayBigBoldBlack = GoogleFonts.getFont(
  Strings.fontName,
  fontSize: 25,
  fontWeight: FontWeight.bold,
  color: Colors.black,
);
TextStyle displayNormalWhite = GoogleFonts.getFont(
  Strings.fontName,
  fontSize: 15,
  fontWeight: FontWeight.w300,
  color: Colors.white,
);
TextStyle displayNormalWhiteBold = GoogleFonts.getFont(
  Strings.fontName,
  fontSize: 15,
  fontWeight: FontWeight.w500,
  color: Colors.white,
);
