import 'package:flutter/material.dart';

import '../constants/color_const.dart';

class AppTheme {
  static final lightTheme = ThemeData(
    brightness: Brightness.light,
    cardColor: Colors.white,
    textTheme: TextTheme(displaySmall: TextStyle()),
    scaffoldBackgroundColor: Colors.white,
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.white,
      foregroundColor: Colors.white,
    ),
  );

  static final darkTheme = ThemeData(
    brightness: Brightness.dark,
    cardColor: Colors.black,
    scaffoldBackgroundColor: Colors.black,
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.black,
      foregroundColor: Colors.white,
    ),
  );
}
