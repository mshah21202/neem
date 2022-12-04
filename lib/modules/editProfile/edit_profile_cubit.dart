import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neem/modules/editProfile/edit_profile_states.dart';
import 'package:neem/modules/product/product_states.dart';
import 'package:neem/services/network/dio_helper.dart';
import 'package:neem/services/network/endpoints.dart';

class EditProfileCubit extends Cubit<EditProfileStates> {
  EditProfileCubit() : super(InitialProfileState());

  static EditProfileCubit get(context) => BlocProvider.of(context);

  String? errorMessage;

  Future<void> updateUser(
      {required String name,
      required String email,
      required String username,
      required String phone,
      required String token,
      String? newPassword}) async {
    emit(RequestEditProfile());
    await DioHelper.postData(path: UPDATEUSER, token: token, body: {
      "name": name,
      "email": email,
      "username": username,
      "phone": phone,
      "newPassword": newPassword,
    }).then((value) {
      emit(UpdatedProfileState());
      print(value);
    }).catchError((error) {
      errorMessage = error.response?.data;
      emit(ErrorUpdateProfileState());
      print(error);
    });
  }
}
