// ignore_for_file: prefer_const_constructors

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neem/Theme/app_size_manager.dart';
import 'package:neem/Theme/color_manager.dart';
import 'package:neem/Theme/string.dart';
import 'package:neem/Theme/theme.dart';
import 'package:neem/modules/ForgotPassword/forgot_password_screen.dart';
import 'package:neem/modules/Home/home_screen.dart';
import 'package:neem/modules/LogIn/login_cubit.dart';
import 'package:neem/modules/LogIn/login_states.dart';
import 'package:neem/modules/Register/register_cubit.dart';
import 'package:neem/modules/Register/register_screen.dart';
import 'package:neem/modules/mainLayout/main_layout_screen.dart';

class LogInScreen extends StatelessWidget {
  LogInScreen({Key? key}) : super(key: key);
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginCubit, LoginStates>(listener: (context, state) {
      if (state is SuccessLoginState) {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (_) => MainLayout()));
      }
      if (state is ErrorLoginState) {
        showDialog(context: context, builder: _errorPopUpDialog);
      }
      if (state is WrongPasswordState) {
        showDialog(context: context, builder: _wrongPassPopUpDialog);
      }
      if (state is UserNotFoundState) {
        showDialog(context: context, builder: _userNotFoundPopUpDialog);
      }
    }, builder: (context, state) {
      var cubit = LoginCubit.get(context);
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
                        controller: usernameController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Enter your username";
                          }
                        },
                        decoration: InputDecoration(label: Text("Username")),
                      ),
                      SizedBox(
                        height: SizeManager.s20,
                      ),
                      TextFormField(
                        controller: passwordController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Enter your password";
                          }
                        },
                        decoration: InputDecoration(label: Text("Password")),
                        obscureText: true,
                      ),
                      SizedBox(
                        height: SizeManager.s20,
                      ),
                      Center(
                        child: state is RequestLoginState
                            ? CircularProgressIndicator()
                            : TextButton.icon(
                                onPressed: () {
                                  if (_formKey.currentState!.validate()) {
                                    cubit.login(
                                      username: usernameController.text,
                                      password: passwordController.text,
                                    );
                                  }
                                },
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
    });
  }

  Widget _errorPopUpDialog(BuildContext context) {
    return AlertDialog(
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Text("Something went wrong"),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('Close'),
        ),
      ],
    );
  }

  Widget _wrongPassPopUpDialog(BuildContext context) {
    return AlertDialog(
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Text("Password is wrong"),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('Close'),
        ),
      ],
    );
  }

  Widget _userNotFoundPopUpDialog(BuildContext context) {
    return AlertDialog(
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Text("User not found!"),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('Close'),
        ),
      ],
    );
  }
}
