import 'package:flutter/material.dart';

class AppColors {
  //static const primaryColorWinter = Color.fromARGB(255, 192, 94, 94);
  static const primaryColorWinter = Colors.lightBlueAccent;
  static const accentColorWinter = Colors.lightGreenAccent;
  static const primaryColorSummer = Color.fromARGB(255, 192, 94, 94);
  static const accentColorSummer = Colors.yellowAccent;
  static const backgroundColor = Color(0xFFFFFFFF);
  static const surfaceColor = Color(0xFFF5F5F5);

  // Risk level colors
  static const risk1Color = Color(0xFF4EAF3C); // Green
  static const risk2Color = Color(0xFFFFED01); // Yellow
  static const risk3Color = Color(0xFFF29200); // Orange
  static const risk4Color = Color(0xFFE51E1B); // Red
  static const risk5Color = Color.fromARGB(255, 28, 32, 30); // Black
  static const unknownRiskColor = Color(0xFF808080); // Grey

  // Risk text colors
  static const riskTextLight = Color.fromARGB(255, 0, 0, 0);
  static const riskTextDark = Color(0xFFE51E1B);

  // UI Colors
  static const successColor = Color(0xFF4CAF50);
  static const errorColor = Color(0xFFE53935);
  static const warningColor = Color(0xFFFB8C00);
  static const infoColor = Color(0xFF1976D2);
}
