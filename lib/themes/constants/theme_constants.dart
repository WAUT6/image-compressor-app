import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ThemeConstants {
  // Background colors
  static const Color backgroundColorVariantOne = Color(0xff931a30);
  static const Color backgroundColorVariantTwo = Color(0xffa83411);
  static const Color backgroundColorVariantThree = Color(0xff1e1e1e);
  static const Color backgroundColorVariantFour = Color(0xff2d221c);

  static const Color accentColor = Color(0xffec1146);
  static TextTheme textTheme = GoogleFonts.redHatDisplayTextTheme();
  static const Color primaryColor = Colors.white;

  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    primaryColor: primaryColor,
    highlightColor: accentColor,
    textTheme: textTheme,
  );
}
