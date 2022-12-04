// ignore_for_file: prefer_const_constructors

import 'dart:io';
import 'dart:ui';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:neem/Theme/theme.dart';
import 'package:neem/modules/Home/home_screen.dart';
import 'package:neem/modules/LogIn/login_cubit.dart';
import 'package:neem/modules/LogIn/login_screen.dart';
import 'package:neem/modules/LogIn/login_states.dart';
import 'package:neem/modules/OnBoarding/on_boarding_screen.dart';
import 'package:path_provider/path_provider.dart';
import 'modules/mainLayout/main_layout_screen.dart';

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

Future<void> main() async {
  HttpOverrides.global = MyHttpOverrides();
  WidgetsFlutterBinding.ensureInitialized();
  final directory = await getApplicationDocumentsDirectory();
  Hive.init(directory.path);
  runApp(const Neem());
}

class Neem extends StatelessWidget {
  const Neem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(create: ((context) => LoginCubit())),
        ],
        child: MaterialApp(
          theme: appTheme(),
          home: MediaQuery(
            data: MediaQueryData.fromWindow(window).copyWith(
                gestureSettings: DeviceGestureSettings(touchSlop: kTouchSlop)),
            child: BlocConsumer<LoginCubit, LoginStates>(
              builder: (context, state) {
                LoginCubit cubit = LoginCubit.get(context);
                if (state is SuccessLoginState) {
                  return MainLayout();
                } else {
                  bool skip = cubit.skip;
                  return !skip ? OnBoardingScreen() : LogInScreen();
                }
              },
              listener: (BuildContext context, Object? state) {
                if (state is! SuccessLoginState) {
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (_) => LogInScreen()));
                }
              },
              listenWhen: (previous, current) {
                if (previous is SuccessLoginState) {
                  return true;
                } else {
                  return false;
                }
              },
            ),
          ),
          debugShowCheckedModeBanner: false,
        ));
  }
}
