import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

abstract class Ttypography {
  static Color backgroundColor =
      const HSLColor.fromAHSL(0.21, 235, 0.11, 0.11).toColor();

  static TextStyle get normalText {
    return GoogleFonts.josefinSans().copyWith(
      fontSize: 12,
      fontWeight: FontWeight.w400,
    );
  }
}
