// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neem/Theme/app_size_manager.dart';
import 'package:neem/Theme/color_manager.dart';
import 'package:neem/Theme/theme.dart';
import 'package:neem/modules/LogIn/login_cubit.dart';
import 'package:neem/modules/LogIn/login_screen.dart';
import 'package:neem/modules/OrderDetails/order_details_list_screen.dart';
import 'package:neem/modules/OrderDetails/order_list_states.dart';
import 'package:neem/modules/editProfile/edit_profile_page.dart';

import '../LogIn/login_states.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginCubit, LoginStates>(
      builder: (context, state) {
        LoginCubit cubit = LoginCubit.get(context);
        return state is! RequestLoginState
            ? Scaffold(
                body: Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: PaddingManager.p20,
                    vertical: PaddingManager.p10),
                child: SizedBox(
                  height: MediaQuery.of(context).size.height * 0.5,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Icon(
                        Icons.account_circle,
                        size: MediaQuery.of(context).size.width * 0.3,
                      ),
                      Text(
                        "Welcome, ${cubit.userModel!.name}",
                        style: Theme.of(context)
                            .textTheme
                            .headlineLarge!
                            .copyWith(
                                color: ColorManager.black,
                                fontWeight: FontWeight.bold,
                                fontSize:
                                    MediaQuery.of(context).size.width * 0.07),
                      ),
                      TextButton.icon(
                        icon: Icon(
                          Icons.edit,
                          color: ColorManager.white,
                        ),
                        label: Text(
                          "Edit Profile",
                          style: Theme.of(context)
                              .textTheme
                              .headlineLarge!
                              .copyWith(color: ColorManager.white),
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => BlocProvider.value(
                                value: LoginCubit.get(context),
                                child: EditProfileScreen(),
                              ),
                            ),
                          );
                        },
                        style: mainButtonStyle(),
                      ),
                      TextButton.icon(
                        icon: Icon(
                          Icons.history,
                          color: ColorManager.white,
                        ),
                        label: Text(
                          "Past Orders",
                          style: Theme.of(context)
                              .textTheme
                              .headlineLarge!
                              .copyWith(color: ColorManager.white),
                        ),
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (_) => OrderDetailsListScreen()));
                        },
                        style: mainButtonStyle(),
                      ),
                      TextButton.icon(
                        icon: Icon(
                          Icons.logout,
                          color: ColorManager.white,
                        ),
                        label: Text(
                          "Log Out",
                          style: Theme.of(context)
                              .textTheme
                              .headlineLarge!
                              .copyWith(color: ColorManager.white),
                        ),
                        onPressed: () {
                          cubit.logout();
                        },
                        style: mainButtonStyle(),
                      ),
                    ],
                  ),
                ),
              ))
            : Center();
      },
      listener: (BuildContext context, Object? state) {
        if (state is LogOutState) {
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (_) => LogInScreen()));
        }
      },
    );
  }
}
