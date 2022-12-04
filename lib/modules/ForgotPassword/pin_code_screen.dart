// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neem/Theme/app_size_manager.dart';
import 'package:neem/Theme/color_manager.dart';
import 'package:neem/Theme/theme.dart';
import 'package:neem/modules/ForgotPassword/change_password_screen.dart';

import 'forgot_password_cubit.dart';
import 'forgot_password_states.dart';
// ignore_for_file: prefer_const_literals_to_create_immutables

class PinCodeScreen extends StatelessWidget {
  PinCodeScreen({Key? key}) : super(key: key);
  final List<FocusNode> _nodes = [
    FocusNode(),
    FocusNode(),
    FocusNode(),
    FocusNode(),
  ];
  final List<TextEditingController> _controllers = [
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
  ];

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ForgotPasswordCubit, ForgotPasswordStates>(
        listener: (context, state) {
      if (state is ChangePasswordState) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (_) => BlocProvider.value(
              value: ForgotPasswordCubit.get(context),
              child: ChangePasswordScreen(),
            ),
          ),
        );
      }
    }, builder: (context, state) {
      ForgotPasswordCubit cubit = ForgotPasswordCubit.get(context);
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
                        controller: _controllers[0],
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
                        controller: _controllers[1],
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
                        controller: _controllers[2],
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
                        controller: _controllers[3],
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
                    String result = '';
                    for (var pin in _controllers) {
                      result = result + pin.text;
                    }
                    int pin = int.parse(result);
                    cubit.confirmPin(email: cubit.email, pin: pin);
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
    });
  }
}
