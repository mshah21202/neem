import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neem/modules/favorite/favorite_states.dart';
import 'package:neem/services/network/dio_helper.dart';
import 'package:neem/services/network/endpoints.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../models/product_model.dart';

class FavoriteCubit extends Cubit<FavoriteStates> {
  FavoriteCubit() : super(InitialFavoriteState()) {
    loadToken().then((value) {
      loadProducts({});
    });
  }

  static FavoriteCubit get(BuildContext context) => BlocProvider.of(context);

  List<ProductModel> products = [];
  String _token = "";
  int page = 1;
  int totalPages = 1;

  Future<void> loadToken() async {
    var prefs = await SharedPreferences.getInstance();
    var token = prefs.getString("token");
    _token = token ?? "";
  }

  void loadProducts(Map<String, dynamic> params) async {
    // print("Page: $page");
    // print("Total Pages: $totalPages");
    if (page - 1 >= totalPages || state is LoadingFavoritesState) return;
    emit(LoadingFavoritesState());
    params.putIfAbsent("PageNumber", () => page);
    Response? response = await DioHelper.getData(
      path: FAVORITE,
      query: params,
      token: _token,
    ).then((response) {
      for (var p in response.data) {
        ProductModel product = ProductModel.fromJson(p);
        products.add(product);
      }
      page++;
      emit(LoadedFavoritesState());
    }).catchError((error) {
      print(error);
      emit(ErrorFavoritesState());
    });
  }

  Future<void> addRemoveFavorite(int index) async {
    Response? response = await DioHelper.postData(
      path: FAVORITE + products[index].id.toString(),
      token: _token,
    ).then((response) {
      products[index].favorite = !products[index].favorite;
      products.removeAt(index);
      emit(UpdatedFavoriteState());
    }).catchError((error) {
      print(error);
      emit(ErrorFavoritesState());
    });
  }

  void localDelete(int index) {
    products.removeAt(index);
    emit(UpdatedFavoriteState());
  }
}
