import 'package:flutter/cupertino.dart';

class LivTheme {
  static CupertinoThemeData getThemeData() {
    const primaryColor = Color.fromRGBO(97, 0, 68, 0.9);
    const secondaryColor = CupertinoColors.white;

    return const CupertinoThemeData(
      brightness: Brightness.light,
      primaryColor: primaryColor,
      primaryContrastingColor: secondaryColor,
      textTheme: CupertinoTextThemeData(
        primaryColor: primaryColor,
      ),
      barBackgroundColor: secondaryColor,
      scaffoldBackgroundColor: secondaryColor,
    );
  }
}
