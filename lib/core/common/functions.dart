import 'package:flutter/cupertino.dart';

const int COLOR_STARTING_HEX = 0xFF000000;

Color hexToColor(String hexColorCode) {
  return new Color(
      int.parse(hexColorCode.substring(1, 7), radix: 16) + COLOR_STARTING_HEX);
}
