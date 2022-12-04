// import 'package:cubit/cubit.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neem/models/user_model.dart';
import 'package:neem/modules/LogIn/login_states.dart';
import 'package:neem/services/network/dio_helper.dart';
import 'package:neem/services/network/endpoints.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginCubit extends Cubit<LoginStates> {
  LoginCubit() : super(InitialLoginState()) {
    userModel =
        UserModel(name: "", email: "", username: "", token: "", phone: "");
    loadToken().then((value) {
      loadUserModel();
    });
  }

  Future<void> loadToken() async {
    var prefs = await SharedPreferences.getInstance();
    var _token = prefs.getString("token");
    if (_token == null || _token.isEmpty) {
      emit(ErrorLoginState());
    } else {
      token = _token;
      emit(SuccessLoginState());
    }

    skip = prefs.getBool("onBoardingSkip") ?? false;
  }

  void loadUserModel() async {
    // emit(RequestLoginState());
    await DioHelper.getData(path: ACCOUNT, token: token).then((response) {
      userModel = UserModel.fromJson(response.data);
      userModel!.token = token;
      emit(SuccessLoginState());
    }).catchError((error) {
      print(error);
      emit(ErrorLoginState());
    });
  }

  static LoginCubit get(BuildContext context) => BlocProvider.of(context);

  String token = "";
  UserModel? userModel;
  bool skip = false;

  Future<void> login(
      {required String username, required String password}) async {
    emit(RequestLoginState());
    Response? response = await DioHelper.postData(
      path: LOGIN,
      body: {
        "username": username,
        "password": password,
      },
    ).then((response) async {
      final prefs = await SharedPreferences.getInstance();
      prefs.setString("token", response.data["token"]);
      token = response.data["token"];
      userModel = UserModel.fromJson(response.data);
      emit(SuccessLoginState());
    }).catchError((error) {
      print(error.toString());
      if (error.response.statusCode == 401) {
        emit(WrongPasswordState());
      } else if (error.response.statusCode == 404) {
        emit(UserNotFoundState());
      } else {
        emit(ErrorLoginState());
      }
    });
  }

  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString("token", "");
    token = "";
    emit(LogOutState());
  }
}
