// app_theme.dart
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static TextStyle poppins({
    FontWeight fontWeight = FontWeight.w400,
    Color color = const Color.fromRGBO(34, 31, 31, 1),
    double fontSize = 14,
  }) {
    return GoogleFonts.poppins(
        fontWeight: fontWeight, color: color, fontSize: fontSize);
  }

  static const Color primaryColor = Color.fromRGBO(14, 161, 125, 1);
  static const Color primaryLightColor = Color.fromRGBO(255, 255, 255, 1);
  static const Color textColor = Color.fromRGBO(0, 0, 0, 1);
  static const Color textColorLight = Color.fromRGBO(0, 0, 0, 0.4);
  static const Color iconColor = Color.fromRGBO(255, 255, 255, 1);

  static BoxDecoration boxDecoration = BoxDecoration(
    color: primaryLightColor,
    borderRadius: BorderRadius.circular(8),
    boxShadow: const [
      BoxShadow(
          color: Color.fromRGBO(0, 0, 0, 0.15),
          offset: Offset(0, 3),
          blurRadius: 10)
    ],
  );

  static InputDecoration textFieldDecoration(String text) {
    return InputDecoration(
        label: Text(text, style: lightTheme.textTheme.bodyMedium),
        border: const OutlineInputBorder(
          borderSide: BorderSide.none,
        ));
  }

  static final ThemeData lightTheme = ThemeData(
      primaryColor: textColor,
      textTheme: TextTheme(
        titleLarge: poppins(
            fontWeight: FontWeight.w600, fontSize: 16, color: textColor),
        titleMedium: poppins(
            fontWeight: FontWeight.w500,
            fontSize: 15,
            color: primaryLightColor),
        titleSmall: poppins(
            color: const Color.fromRGBO(0, 0, 0, 0.8), fontSize: 12, fontWeight: FontWeight.w400),
        bodyLarge: poppins(
            color: primaryColor, fontSize: 12, fontWeight: FontWeight.w400),
        bodyMedium: poppins(
            color: textColorLight, fontSize: 12, fontWeight: FontWeight.w400),
        bodySmall: poppins(
            color: const Color.fromRGBO(0, 0, 0, 0.6),
            fontSize: 12,
            fontWeight: FontWeight.w400),
      ),
      iconTheme: const IconThemeData(size: 24, color: textColor),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
            fixedSize: const Size(350, 48),
            backgroundColor: const Color.fromRGBO(14, 161, 125, 1),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))),
      ));
}
