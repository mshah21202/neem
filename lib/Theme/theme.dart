// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:neem/Theme/app_size_manager.dart';
import 'package:neem/Theme/color_manager.dart';

ThemeData appTheme() {
  return ThemeData(
    inputDecorationTheme: InputDecorationTheme(
        border: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey),
            borderRadius: BorderRadius.circular(SizeManager.s15))),
    textTheme: getTextTheme(),
    primaryColor: ColorManager.primaryColor,
    scaffoldBackgroundColor: ColorManager.white,
    appBarTheme: const AppBarTheme(
        backgroundColor: ColorManager.primaryColor,
        systemOverlayStyle:
            SystemUiOverlayStyle(statusBarColor: Colors.transparent)),
    colorScheme: ColorScheme.fromSwatch().copyWith(
      secondary: ColorManager.accentColor,
      primary: ColorManager.primaryColor,
    ),
  );
}

TextTheme getTextTheme() {
  return TextTheme(
      // caption: TextStyle(
      //   color: Colors.black,
      //   fontWeight: FontWeight.w600,
      //   fontSize: SizeManager.s18,
      // ),
      // button: TextStyle(color: ColorManager.white),
      // displayLarge: TextStyle(color: ColorManager.primaryColor)
      headlineLarge: TextStyle(fontSize: SizeManager.s20));
}

TextStyle getLinkStyle() {
  return getTextTheme()
      .headlineLarge!
      .copyWith(color: ColorManager.primaryColor);
}

ButtonStyle mainButtonStyle() {
  return TextButton.styleFrom(
      backgroundColor: ColorManager.primaryColor,
      minimumSize: Size(double.infinity, 50),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(SizeManager.s15)));
}

ButtonStyle secondaryButtonStyle() {
  return TextButton.styleFrom(
    backgroundColor: Colors.transparent,
    minimumSize: Size(100, 50),
  );
}

AppBar mainAppBar(BuildContext context) {
  return AppBar(
    title: Text(
      "Neem",
      style: Theme.of(context)
          .textTheme
          .headlineLarge!
          .copyWith(color: ColorManager.white),
    ),
    leading: null,
    automaticallyImplyLeading: false,
  );
}
