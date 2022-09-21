// ignore_for_file: prefer_const_constructors

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neem/Theme/app_size_manager.dart';
import 'package:neem/Theme/color_manager.dart';
import 'package:neem/Theme/theme.dart';
import 'package:neem/modules/LogIn/login_screen.dart';
import 'package:neem/modules/Register/register_cubit.dart';
import 'package:neem/modules/Register/register_states.dart';

class RegisterScreen extends StatelessWidget {
  RegisterScreen({Key? key}) : super(key: key);
  final GlobalKey _formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController usernameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RegisterCubit(),
      child:
          BlocBuilder<RegisterCubit, RegisterStates>(builder: (context, state) {
        return Scaffold(
          appBar: mainAppBar(context),
          body: SingleChildScrollView(
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.manual,
            child: Center(
              child: SafeArea(
                child: SizedBox(
                  // height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width * 0.9,
                  child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        // SizedBox(
                        //   height: MediaQuery.of(context).size.height * 0.15,
                        // ),
                        SizedBox(
                          height: SizeManager.s20,
                        ),
                        Text(
                          "Register",
                          style: Theme.of(context)
                              .textTheme
                              .displaySmall!
                              .copyWith(color: ColorManager.primaryColor),
                        ),
                        SizedBox(
                          height: SizeManager.s20,
                        ),
                        TextFormField(
                          controller: nameController,
                          decoration: InputDecoration(label: Text("Name")),
                        ),
                        SizedBox(
                          height: SizeManager.s20,
                        ),
                        TextFormField(
                          controller: usernameController,
                          decoration: InputDecoration(label: Text("Username")),
                        ),
                        SizedBox(
                          height: SizeManager.s20,
                        ),
                        TextFormField(
                          controller: emailController,
                          decoration: InputDecoration(label: Text("Email")),
                        ),
                        SizedBox(
                          height: SizeManager.s20,
                        ),
                        TextFormField(
                          controller: phoneController,
                          decoration: InputDecoration(label: Text("Phone")),
                        ),
                        SizedBox(
                          height: SizeManager.s20,
                        ),
                        TextFormField(
                          controller: passwordController,
                          decoration: InputDecoration(label: Text("Password")),
                          obscureText: true,
                        ),
                        SizedBox(
                          height: SizeManager.s20,
                        ),
                        TextFormField(
                          decoration:
                              InputDecoration(label: Text("Confirm Password")),
                          obscureText: true,
                        ),
                        SizedBox(
                          height: SizeManager.s20,
                        ),
                        TextButton.icon(
                          onPressed: () {
                            RegisterCubit cubit = RegisterCubit.get(context);
                            cubit.register(
                                email: emailController.text,
                                password: passwordController.text,
                                name: nameController.text,
                                username: usernameController.text,
                                phone: phoneController.text);
                          },
                          icon: Icon(
                            Icons.create,
                            color: ColorManager.white,
                          ),
                          label: Text(
                            "Register",
                            style: Theme.of(context)
                                .textTheme
                                .headlineSmall!
                                .copyWith(color: ColorManager.white),
                          ),
                          style: mainButtonStyle(),
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
                              TextSpan(text: "Already Have an account? "),
                              TextSpan(
                                  text: "Login",
                                  style: getLinkStyle(),
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () => Navigator.pop(context)),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: SizeManager.s20,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      }),
    );
  }
}
