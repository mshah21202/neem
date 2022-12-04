// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neem/Theme/app_size_manager.dart';
import 'package:neem/Theme/theme.dart';
import 'package:neem/modules/ForgotPassword/forgot_password_cubit.dart';
import 'package:neem/modules/ForgotPassword/forgot_password_states.dart';
import 'package:neem/modules/LogIn/login_screen.dart';

import '../../Theme/color_manager.dart';

class ChangePasswordScreen extends StatelessWidget {
  const ChangePasswordScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController passwordController = TextEditingController();
    final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

    return BlocConsumer<ForgotPasswordCubit, ForgotPasswordStates>(
        listener: (context, state) {
      if (state is PasswordChangedState) {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => LogInScreen()));
      }
    }, builder: (context, state) {
      ForgotPasswordCubit cubit = ForgotPasswordCubit.get(context);
      return Scaffold(
        appBar: mainAppBar(context),
        body: Center(
          child: SizedBox(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width * 0.9,
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "Enter your new password",
                    style: Theme.of(context)
                        .textTheme
                        .headlineMedium!
                        .copyWith(color: ColorManager.primaryColor),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(
                    height: SizeManager.s20,
                  ),
                  TextFormField(
                    controller: passwordController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Enter a password";
                      } else if (!RegExp(
                              "^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[#?!@\$ %^&*-]).{8,}\$")
                          .hasMatch(value)) {
                        return "Minimum 8 characters, at least 1 upper case letter, 1 lower case letter, 1 number and 1 special character";
                      }
                    },
                    decoration: InputDecoration(label: Text("Password")),
                    obscureText: true,
                  ),
                  Center(
                    child: TextButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          cubit.changePassword(
                              password: passwordController.text);
                        }
                      },
                      style: mainButtonStyle(),
                      child: Text(
                        "Confirm Password",
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
        ),
      );
    });
  }
}
