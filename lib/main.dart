import 'package:flutter/material.dart';
import 'package:neem/Theme/theme.dart';
import 'package:neem/modules/OnBoarding/on_boarding_screen.dart';

void main() {
  runApp(const Neem());
}

class Neem extends StatelessWidget {
  const Neem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: AppTheme.getThemeData(),
      home: OnBoardingScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
