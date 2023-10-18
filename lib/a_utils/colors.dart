import 'package:flutter/material.dart';

class AppColors {
  static const primary = Colors.black87;
  //
  static final newRed = HexColor("#F16034");
  static final newLightRed = HexColor("#FCF4F1");
  //
  static final start0 = HexColor("#1D1D1D");

  static final rating0 = HexColor("#2F820C");
}

class HexColor extends Color {
  static int _getColorFromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll("#", "");
    if (hexColor.length == 6) {
      hexColor = "FF$hexColor";
    }

    final hexNum = int.parse(hexColor, radix: 16);

    if (hexNum == 0) {
      return 0xff000000;
    }

    return hexNum;
  }

  HexColor(final String hexColor) : super(_getColorFromHex(hexColor));
}
