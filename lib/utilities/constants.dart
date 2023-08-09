import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// Color Themes
Color mintyGreen = const Color.fromRGBO(13, 201, 150, 1);

class AppTextStyles {
  static final TextStyle header = GoogleFonts.poppins(
    fontSize: 24,
    fontWeight: FontWeight.bold,
    color: Colors.black,
  );

  static final TextStyle smallHeaderSlightlyBold = GoogleFonts.poppins(
    fontSize: 18,
    fontWeight: FontWeight.w500,
    color: Colors.black,
  );

  static final TextStyle normal = GoogleFonts.poppins(
    fontSize: 16,
    color: Colors.black,
  );
  static final TextStyle normalGreen = GoogleFonts.poppins(
    fontSize: 16,
    color: Colors.green,
  );

  static final TextStyle small = GoogleFonts.poppins(
    fontSize: 14,
    color: Colors.grey,
  );

  static final TextStyle smallBold = GoogleFonts.poppins(
    fontSize: 14,
    fontWeight: FontWeight.bold,
    color: Colors.grey,
  );
}
