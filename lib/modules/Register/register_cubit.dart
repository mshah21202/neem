import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neem/modules/Register/register_states.dart';
import 'package:neem/services/network/dio_helper.dart';
import 'package:neem/services/network/endpoints.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../models/register_model.dart';

class RegisterCubit extends Cubit<RegisterStates> {
  RegisterCubit() : super(InitialRegisterState());

  static RegisterCubit get(BuildContext context) => BlocProvider.of(context);

  RegisterModel? registerModel;

  Future<void> register({
    required String email,
    required String password,
    required String name,
    required String username,
    required String phone,
  }) async {
    emit(RequestRegisterState());
    Response? response = await DioHelper.postData(path: REGISTER, body: {
      "email": email,
      "password": password,
      "name": name,
      "username": username,
      "phone": phone,
    }).then((response) async {
      registerModel = RegisterModel.fromJson(response.data);
      final prefs = await SharedPreferences.getInstance();
      prefs.setString("token", registerModel!.token.toString());
      emit(SuccessRegisterState());
    }).catchError((error) {
      print(error.toString());
      emit(ErrorRegisterState());
    });
  }
}
