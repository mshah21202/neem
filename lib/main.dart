import 'dart:io';

import 'package:flutter/material.dart';
import 'package:neem/Theme/theme.dart';
import 'package:neem/modules/OnBoarding/on_boarding_screen.dart';

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

void main() {
  HttpOverrides.global = MyHttpOverrides();
  runApp(const Neem());
}

class Neem extends StatelessWidget {
  const Neem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: appTheme(),
      home: OnBoardingScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
