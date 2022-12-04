import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neem/extensions/string_extension.dart';
import 'package:neem/modules/Home/home_screen_states.dart';
import 'package:neem/services/network/dio_helper.dart';
import 'package:neem/services/network/endpoints.dart';

import 'drawer_states.dart';

class DrawerCubit extends Cubit<DrawerStates> {
  DrawerCubit() : super(InitialDrawerState()) {
    loadCategories();
  }

  static DrawerCubit get(BuildContext context) => BlocProvider.of(context);

  double minPrice = 0;
  double maxPrice = 999;
  String orderBy = "new";
  List<String> categories = ["All"];
  String category = "All";

  void changeCategoryValue(String value) {
    category = value;
    // page = 1; // Reset page

    // loadProducts({"Category": category.toLowerCase()}, reset: true);
    emit(ChangeCategoryValueState());
  }

  void changeOrderByValue(String value) {
    orderBy = value;
    // page = 1; // Reset page

    // loadProducts({"Category": category.toLowerCase()}, reset: true);
    emit(ChangeOrderByValueState());
  }

  void loadCategories() async {
    emit(LoadingCategoriesState());
    Response? response = await DioHelper.getData(path: CATEGORY).then(
      (response) {
        // emit(LoadingHomeProducts());
        for (String category in response.data) {
          categories.add(category.capitalize());
        }
        category = categories[0];
        // print(categories);
        emit(LoadedCategoriesState());
      },
    ).catchError((error) {
      print(error);
      emit(ErrorDrawerState());
    });
  }

  void changePriceRangeValues(double start, double end) {
    minPrice = start;
    maxPrice = end;

    emit(ChangePriceRangeValueState());
  }
}
