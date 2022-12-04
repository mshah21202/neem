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
import 'package:neem/modules/mainLayout/main_layout_screen.dart';

import '../Home/home_screen.dart';

class RegisterScreen extends StatelessWidget {
  RegisterScreen({Key? key}) : super(key: key);
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController usernameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RegisterCubit(),
      child: BlocConsumer<RegisterCubit, RegisterStates>(
          listener: (context, state) {
        if (state is ErrorRegisterState) {
          showDialog(
            context: context,
            builder: (BuildContext context) => _buildPopupDialog(context),
          );
        } else if (state is SuccessRegisterState) {
          Navigator.of(context)
              .pushReplacement(MaterialPageRoute(builder: (_) => MainLayout()));
        }
      }, builder: (context, state) {
        RegisterCubit cubit = RegisterCubit.get(context);
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
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Enter your name";
                            }
                          },
                          decoration: InputDecoration(label: Text("Name")),
                        ),
                        SizedBox(
                          height: SizeManager.s20,
                        ),
                        TextFormField(
                          controller: usernameController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Enter your username";
                            } else if (value.length < 5) {
                              return "Your username should be 5 characters or more";
                            }
                          },
                          decoration: InputDecoration(label: Text("Username")),
                        ),
                        SizedBox(
                          height: SizeManager.s20,
                        ),
                        TextFormField(
                          controller: emailController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Enter your email address";
                            } else if (!RegExp(
                                    r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                .hasMatch(value)) {
                              return "Enter a valid email address";
                            }
                          },
                          decoration: InputDecoration(label: Text("Email")),
                        ),
                        SizedBox(
                          height: SizeManager.s20,
                        ),
                        TextFormField(
                          controller: phoneController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Enter your phone number";
                            } else if (!RegExp("[0][0-9]{9}").hasMatch(value)) {
                              return "Enter a valid number Ex. 07xxxxxxxx";
                            }
                          },
                          decoration: InputDecoration(label: Text("Phone")),
                        ),
                        SizedBox(
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
                        SizedBox(
                          height: SizeManager.s20,
                        ),
                        TextFormField(
                          decoration:
                              InputDecoration(label: Text("Confirm Password")),
                          validator: (value) {
                            if (value != passwordController.text) {
                              return "Passwords don't match";
                            }
                          },
                          obscureText: true,
                        ),
                        SizedBox(
                          height: SizeManager.s20,
                        ),
                        TextButton.icon(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              cubit.register(
                                  email: emailController.text,
                                  password: passwordController.text,
                                  name: nameController.text,
                                  username: usernameController.text,
                                  phone: phoneController.text);
                            }
                          },
                          icon: state is RequestRegisterState
                              ? CircularProgressIndicator(
                                  color: ColorManager.white)
                              : Icon(
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

  Widget _buildPopupDialog(BuildContext context) {
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
}
