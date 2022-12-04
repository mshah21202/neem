import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neem/extensions/string_extension.dart';
import 'package:neem/models/product_model.dart';
import 'package:neem/modules/Home/home_screen_states.dart';
import 'package:neem/services/network/dio_helper.dart';
import 'package:neem/services/network/endpoints.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeCubit extends Cubit<HomeStates> {
  HomeCubit() : super(InitialHomeState()) {
    loadToken().then((_) {
      loadProducts();
      // loadCategories();
    });
  }

  static HomeCubit get(BuildContext context) => BlocProvider.of(context);

  List<ProductModel> products = [];
  List<String> categories = ["All"];
  String category = "All";
  String _token = "";
  int minPrice = 0;
  int maxPrice = 999;
  String orderBy = "";
  int page = 1;
  int totalPages = 1;

  Future<void> loadToken() async {
    var prefs = await SharedPreferences.getInstance();
    _token = prefs.getString("token") ?? "";
  }

  void loadProducts(
      {int? page,
      String category = "All",
      int minPrice = 0,
      int maxPrice = 999,
      String orderBy = "",
      bool reset = false}) async {
    // print("Page: $page");
    // print("Total Pages: $totalPages");
    page ??= this.page;
    if (reset) page = 1;
    if ((page - 1 >= totalPages && totalPages != 0) ||
        state is LoadingHomeProducts) return;
    emit(LoadingHomeProducts());
    // page = params.putIfAbsent("PageNumber", () => page);
    // category.isNotEmpty && category != "All"
    //     ? category = params.putIfAbsent("Category", () => category)
    //     : null;
    // minPrice = params.putIfAbsent("MinPrice", () => minPrice);
    // maxPrice = params.putIfAbsent("MaxPrice", () => maxPrice);
    // orderBy.isNotEmpty
    //     ? orderBy = params.putIfAbsent("OrderBy", () => orderBy)
    //     : null;
    Map<String, dynamic> params = {
      "PageNumber": page,
      "minPrice": minPrice,
      "maxPrice": maxPrice,
    };
    if (category != "All") {
      params.addAll({"Category": category});
    }
    if (orderBy.isNotEmpty) {
      params.addAll({"orderBy": orderBy});
    }
    Response? response = await DioHelper.getData(
      path: PRODUCT,
      query: params,
      token: _token,
    ).then((response) {
      if (reset) products = [];
      for (var p in response.data) {
        ProductModel product = ProductModel.fromJson(p);
        products.add(product);
      }
      this.page = this.page + 1;
      totalPages =
          jsonDecode(response.headers.value("Pagination")!)["totalPages"];
      emit(LoadedPaginatedProducts());
    }).catchError((error) {
      print(error);
      emit(ErrorHomeState());
    });
  }

  // void loadCategories() async {
  //   emit(LoadingHomeProducts());
  //   Response? response = await DioHelper.getData(path: CATEGORY).then(
  //     (response) {
  //       for (String category in response.data) {
  //         categories.add(category.capitalize());
  //       }
  //       category = categories[0];
  //       print(categories);
  //       emit(CategoryUpdatedState());
  //     },
  //   ).catchError((error) {
  //     print(error);
  //     emit(ErrorHomeState());
  //   });
  // }

  // void changeCategoryValue(String value) {
  //   category = value;
  //   page = 1; // Reset page

  //   loadProducts({"Category": category.toLowerCase()}, reset: true);
  //   emit(CategoryUpdatedState());
  // }

  // void changePriceRangeValues(double start, double end) {
  //   minPrice = start.toInt();
  //   maxPrice = end.toInt();

  //   emit(PriceRangeUpdatedState());
  // }

  Future<void> addRemoveFavorite(int index) async {
    Response? response = await DioHelper.postData(
      path: FAVORITE + products[index].id.toString(),
      token: _token,
    ).then((response) {
      products[index].favorite = !products[index].favorite;
      print(response.statusCode);
      emit(FavoriteUpdatedState());
    }).catchError((error) {
      print(error);
      emit(ErrorHomeState());
    });
  }

  void updateFavorite() {
    emit(FavoriteUpdatedState());
  }
}
