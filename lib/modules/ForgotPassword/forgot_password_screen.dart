// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:neem/Theme/app_size_manager.dart';
import 'package:neem/Theme/color_manager.dart';
import 'package:neem/Theme/theme.dart';
import 'package:neem/modules/ForgotPassword/pin_code_screen.dart';

class ForgotPasswordScreen extends StatelessWidget {
  const ForgotPasswordScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: mainAppBar(context),
      body: Center(
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width * 0.9,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "Reset Password",
                style: Theme.of(context)
                    .textTheme
                    .headlineMedium!
                    .copyWith(color: ColorManager.primaryColor),
              ),
              SizedBox(
                height: SizeManager.s20,
              ),
              TextFormField(
                decoration: InputDecoration(label: Text("E-Mail")),
              ),
              SizedBox(
                height: SizeManager.s20,
              ),
              Center(
                child: TextButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PinCodeScreen(),
                      ),
                    );
                  },
                  style: mainButtonStyle(),
                  child: Text(
                    "Reset Password",
                    style: Theme.of(context)
                        .textTheme
                        .headlineSmall!
                        .copyWith(color: ColorManager.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
