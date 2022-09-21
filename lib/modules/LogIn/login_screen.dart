// ignore_for_file: prefer_const_constructors

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:neem/Theme/app_size_manager.dart';
import 'package:neem/Theme/color_manager.dart';
import 'package:neem/Theme/string.dart';
import 'package:neem/Theme/theme.dart';
import 'package:neem/modules/ForgotPassword/forgot_password_screen.dart';
import 'package:neem/modules/Register/register_screen.dart';

class LogInScreen extends StatelessWidget {
  LogInScreen({Key? key}) : super(key: key);
  final GlobalKey _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: mainAppBar(context),
      body: SingleChildScrollView(
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.manual,
        child: Center(
          child: SafeArea(
            child: SizedBox(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width * 0.9,
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  // mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // Text(
                    //   StringManager.loginLabel,
                    //   style: Theme.of(context).textTheme.displayMedium!.copyWith(),
                    // ),
                    // SizedBox(
                    //   height: SizeManager.s20,
                    // ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.15,
                    ),
                    Image.asset("assets/images/login.png"),
                    TextFormField(
                      decoration: InputDecoration(label: Text("Username")),
                    ),
                    SizedBox(
                      height: SizeManager.s20,
                    ),
                    TextFormField(
                      decoration: InputDecoration(label: Text("Password")),
                      obscureText: true,
                    ),
                    SizedBox(
                      height: SizeManager.s20,
                    ),
                    Center(
                      child: TextButton.icon(
                        onPressed: () {},
                        icon: Icon(
                          Icons.login,
                          color: ColorManager.white,
                        ),
                        label: Text(
                          "Login",
                          style: Theme.of(context)
                              .textTheme
                              .headlineSmall!
                              .copyWith(color: ColorManager.white),
                        ),
                        style: mainButtonStyle(),
                      ),
                    ),
                    SizedBox(
                      height: SizeManager.s20,
                    ),
                    RichText(
                      text: TextSpan(
                        style: Theme.of(context)
                            .textTheme
                            .headlineLarge!
                            .copyWith(color: Colors.black),
                        children: [
                          TextSpan(text: "Don't have an account? "),
                          TextSpan(
                            text: "Register",
                            style: getLinkStyle(),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () => Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => RegisterScreen(),
                                    ),
                                  ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: SizeManager.s20,
                    ),
                    RichText(
                      text: TextSpan(
                        style: Theme.of(context)
                            .textTheme
                            .headlineLarge!
                            .copyWith(color: Colors.black),
                        children: [
                          TextSpan(
                            text: "Forgot your password?",
                            style: getLinkStyle(),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () => Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          ForgotPasswordScreen(),
                                    ),
                                  ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
