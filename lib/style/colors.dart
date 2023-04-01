import 'package:flutter/material.dart';
import 'dart:math' as math;

class AppColors {
  static bool isDarkMode = false;

  static Color get primary => Colors.cyan[500]!;
  static Color get lightGreen => const Color(0xffbff964);
  static Color get white => Colors.white;
  static Color get randomColor =>
      Color((math.Random().nextDouble() * 0xFFFFFF).toInt()).withOpacity(1.0);
  static MaterialColor get primarySwatch => Colors.pink;
  static Color get accentColor => isDarkMode ? primary : Colors.grey[600]!;
  static Color get bgColor => isDarkMode ? Colors.black : Colors.grey[50]!;
}
