import 'package:flutter/material.dart';

class MyStyle extends TextStyle {
  const MyStyle({
    required String fontFamily,
    required Color color,
    required FontWeight fontWeight,
    required double fontSize, double letterSpacing = 1}) : super(
      fontFamily: fontFamily,
      color: color,
      fontWeight: fontWeight,
      fontSize: fontSize,
      letterSpacing: letterSpacing,
      decoration: TextDecoration.none
  );
}