import 'dart:ffi';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neem/modules/ForgotPassword/forgot_password_states.dart';
import 'package:neem/services/network/dio_helper.dart';
import 'package:neem/services/network/endpoints.dart';

class ForgotPasswordCubit extends Cubit<ForgotPasswordStates> {
  ForgotPasswordCubit() : super(InitialForgotPasswordState());

  static ForgotPasswordCubit get(BuildContext context) =>
      BlocProvider.of<ForgotPasswordCubit>(context);

  String email = '';
  String _token = '';

  Future<void> requestPin({required String email}) async {
    emit(RequestPinCodeState());
    this.email = email;
    Response? response = await DioHelper.postData(
      path: RESET,
      query: {"email": email},
    ).then((response) {
      emit(ConfirmPinCodeState());
    }).catchError((error) {
      emit(ErrorForgotPasswordState());
    });
  }

  Future<void> confirmPin({required String email, required int pin}) async {
    Response? response = await DioHelper.postData(
      path: RESET_CONFIRM,
      query: {"email": email, "pin": pin},
    ).then((response) {
      _token = response.data["token"];
      emit(ChangePasswordState());
    }).catchError((error) {
      emit(ErrorForgotPasswordState());
    });
  }

  Future<void> changePassword({required String password}) async {
    Response? response = await DioHelper.postData(
      path: CHANGE_PASSWORD,
      token: _token,
      body: {"password": password},
    ).then((response) {
      emit(PasswordChangedState());
    }).catchError((error) {
      emit(ErrorForgotPasswordState());
    });
  }
}
