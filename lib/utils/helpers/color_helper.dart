import 'package:flutter/material.dart';

enum ContrastPreference {
  none,
  light,
  dark,
}

class ColorHelper {
  static int fromHexString(String argbHexString) {
    String useString = argbHexString;
    if (useString.startsWith("#")) {
      useString = useString.substring(1);
    }
    if (useString.length < 8) {
      useString = "FF" + useString;
    }
    if (!useString.startsWith("0x")) {
      useString = "0x" + useString;
    }
    return int.parse(useString);
  }

  static const double _kMinContrastModifierRange = 0.35;
  static const double _kMaxContrastModifierRange = 0.65;

  static Color blackOrWhiteContrastColor(Color sourceColor,
      {ContrastPreference prefer = ContrastPreference.none}) {
    Map<String, double> values = {
      "red": sourceColor.red * 299.0,
      "green": sourceColor.green * 587.0,
      "blue": sourceColor.blue * 114.0
    };

    double value =
        (values['red']! + values['green']! + values['blue']!) / 1000.0 / 255.0;

    if (prefer != ContrastPreference.none) {
      if (value >= _kMinContrastModifierRange &&
          value <= _kMaxContrastModifierRange) {
        return prefer == ContrastPreference.light
            ? const Color(0xFFFFFFFF)
            : const Color(0xFF000000);
      }
    }
    return value > 0.6 ? const Color(0xFF000000) : const Color(0xFFFFFFFF);
  }
}
