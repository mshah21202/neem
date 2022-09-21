// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:neem/Theme/app_size_manager.dart';
import 'package:neem/Theme/color_manager.dart';
import 'package:neem/Theme/theme.dart';
import 'package:neem/modules/ForgotPassword/change_password_screen.dart';
// ignore_for_file: prefer_const_literals_to_create_immutables

class PinCodeScreen extends StatelessWidget {
  PinCodeScreen({Key? key}) : super(key: key);
  final List<FocusNode> _nodes = [
    FocusNode(),
    FocusNode(),
    FocusNode(),
    FocusNode(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: mainAppBar(context),
      body: Center(
        child: SizedBox(
          width: MediaQuery.of(context).size.width * 0.9,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Enter your PIN",
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              SizedBox(
                height: SizeManager.s20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: (MediaQuery.of(context).size.width - 10) / 5,
                    height: (MediaQuery.of(context).size.width - 10) / 5,
                    child: TextFormField(
                      // controller: _controllers[0],
                      focusNode: _nodes[0],
                      maxLength: 1,
                      maxLengthEnforcement: MaxLengthEnforcement.enforced,
                      onChanged: (value) {
                        if (value.isNotEmpty) _nodes[1].requestFocus();
                      },
                      keyboardType: TextInputType.number,
                    ),
                  ),
                  SizedBox(
                    width: (MediaQuery.of(context).size.width - 10) / 5,
                    height: (MediaQuery.of(context).size.width - 10) / 5,
                    child: TextFormField(
                      focusNode: _nodes[1],
                      // controller: _controllers[1],
                      maxLength: 1,
                      onChanged: (value) {
                        if (value.isNotEmpty) _nodes[2].requestFocus();
                        if (value.isEmpty) _nodes[0].requestFocus();
                      },
                      keyboardType: TextInputType.number,
                    ),
                  ),
                  SizedBox(
                    width: (MediaQuery.of(context).size.width - 10) / 5,
                    height: (MediaQuery.of(context).size.width - 10) / 5,
                    child: TextFormField(
                      focusNode: _nodes[2],
                      // controller: _controllers[2],
                      maxLength: 1,
                      onChanged: (value) {
                        if (value.isNotEmpty) _nodes[3].requestFocus();
                        if (value.isEmpty) _nodes[1].requestFocus();
                      },
                      keyboardType: TextInputType.number,
                    ),
                  ),
                  SizedBox(
                    width: (MediaQuery.of(context).size.width - 10) / 5,
                    height: (MediaQuery.of(context).size.width - 10) / 5,
                    child: TextFormField(
                      // controller: _controllers[3],
                      focusNode: _nodes[3],
                      maxLength: 1,
                      onChanged: (value) {
                        // if (value.isNotEmpty) _nodes[1].requestFocus();
                        if (value.isEmpty) _nodes[2].requestFocus();
                      },
                      keyboardType: TextInputType.number,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: SizeManager.s20,
              ),
              TextButton(
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ChangePasswordScreen(),
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
              )
              // SizedBox(
              //   width: MediaQuery.of(context).size.width,
              //   child: Row(
              //     mainAxisAlignment: MainAxisAlignment.center,
              //     children: [
              //       TextFormField(),
              //       TextFormField(),
              //       TextFormField(),
              //       TextFormField(),
              //     ],
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
