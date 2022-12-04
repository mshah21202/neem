// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neem/Theme/theme.dart';
import 'package:neem/modules/LogIn/login_cubit.dart';
import 'package:neem/modules/editProfile/edit_profile_cubit.dart';
import 'package:neem/modules/editProfile/edit_profile_states.dart';

import '../../Theme/app_size_manager.dart';
import '../../Theme/color_manager.dart';
import '../../models/user_model.dart';
import '../LogIn/login_states.dart';

class EditProfileScreen extends StatelessWidget {
  EditProfileScreen({Key? key}) : super(key: key);

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController usernameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => EditProfileCubit(),
      child: Scaffold(
        appBar: mainAppBar(context),
        body: BlocConsumer<LoginCubit, LoginStates>(
          builder: (context, state) {
            LoginCubit loginCubit = LoginCubit.get(context);
            emailController.text = loginCubit.userModel!.email;
            nameController.text = loginCubit.userModel!.name;
            usernameController.text = loginCubit.userModel!.username;
            phoneController.text = loginCubit.userModel!.phone;
            return BlocConsumer<EditProfileCubit, EditProfileStates>(
              builder: (context, state) {
                EditProfileCubit cubit = EditProfileCubit.get(context);
                return SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: PaddingManager.p5,
                        horizontal: PaddingManager.p10),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          SizedBox(
                            height: SizeManager.s20,
                          ),
                          Text(
                            "Edit your profile",
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
                              return null;
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
                              return null;
                            },
                            decoration:
                                InputDecoration(label: Text("Username")),
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
                              return null;
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
                              } else if (!RegExp("[0][0-9]{9}")
                                  .hasMatch(value)) {
                                return "Enter a valid number Ex. 07xxxxxxxx";
                              }
                              return null;
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
                                return null;
                              } else if (!RegExp(
                                      "^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[#?!@\$ %^&*-]).{8,}\$")
                                  .hasMatch(value)) {
                                return "Minimum 8 characters, at least 1 upper case letter, 1 lower case letter, 1 number and 1 special character";
                              }
                              return null;
                            },
                            decoration:
                                InputDecoration(label: Text("Password")),
                            obscureText: true,
                          ),
                          SizedBox(
                            height: SizeManager.s20,
                          ),
                          TextFormField(
                            decoration: InputDecoration(
                                label: Text("Confirm Password")),
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
                                cubit
                                    .updateUser(
                                        name: nameController.text,
                                        email: emailController.text,
                                        username: usernameController.text,
                                        phone: phoneController.text,
                                        token: loginCubit.userModel!.token,
                                        newPassword:
                                            passwordController.text.isEmpty
                                                ? null
                                                : passwordController.text)
                                    .then((value) {
                                  loginCubit.loadUserModel();
                                });
                              }
                            },
                            icon: state is RequestEditProfile
                                ? CircularProgressIndicator(
                                    color: ColorManager.white)
                                : Icon(
                                    Icons.create,
                                    color: ColorManager.white,
                                  ),
                            label: Text(
                              "Update Info",
                              style: Theme.of(context)
                                  .textTheme
                                  .headlineSmall!
                                  .copyWith(color: ColorManager.white),
                            ),
                            style: mainButtonStyle(),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
              listener: (BuildContext context, Object? state) {
                EditProfileCubit cubit = EditProfileCubit.get(context);
                if (state is ErrorUpdateProfileState) {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text("Something went wrong: ${cubit.errorMessage}",
                        style: TextStyle(color: ColorManager.white)),
                  ));
                }

                if (state is UpdatedProfileState) {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text(
                      "Profile updated successfully",
                      style: TextStyle(color: ColorManager.white),
                    ),
                  ));
                }
              },
            );
          },
          listener: (BuildContext context, Object? state) {},
        ),
      ),
    );
  }
}
