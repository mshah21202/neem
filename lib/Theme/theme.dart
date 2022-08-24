import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppTheme {
  static ThemeData getThemeData() {
    return ThemeData(
      // primaryColor: Colors.deepOrange,
      scaffoldBackgroundColor: Colors.white,
      appBarTheme: const AppBarTheme(
          backgroundColor: Colors.deepOrange,
          systemOverlayStyle:
              SystemUiOverlayStyle(statusBarColor: Colors.transparent)),
      colorScheme: ColorScheme.fromSwatch()
          .copyWith(secondary: Colors.amberAccent, primary: Colors.deepOrange),
    );
  }
}
