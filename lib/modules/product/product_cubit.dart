import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:neem/models/product_model.dart';
import 'package:neem/modules/Home/home_screen_cubit.dart';
import 'package:neem/modules/product/product_states.dart';
import 'package:neem/services/network/dio_helper.dart';
import 'package:neem/services/network/endpoints.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProductCubit extends Cubit<ProductStates> {
  ProductCubit({required this.id}) : super(InitialProductState()) {
    loadToken().then((value) {
      getProduct();
      _openBox();
    });
  }

  static ProductCubit get(BuildContext context) => BlocProvider.of(context);

  ProductModel? productModel;
  int quantity = 1;
  int id;
  String _token = "";
  late Box<Map<dynamic, dynamic>> _box;

  Future<void> _openBox() async {
    // Hive.close();
    _box = await Hive.openBox<Map<dynamic, dynamic>>("cart");
    // _box.add({"id" : 18, "quantity" : 1});
  }

  Future<void> loadToken() async {
    var prefs = await SharedPreferences.getInstance();
    _token = prefs.getString("token") ?? "";
  }

  Future<void> getProduct() async {
    emit(LoadingProductState());
    await DioHelper.getData(path: PRODUCT + id.toString(), token: _token)
        .then((response) {
      productModel = ProductModel.fromJson(response.data);
      emit(LoadedProductState());
    }).catchError((error) {
      print(error);
      emit(ErrorProductState());
    });
  }

  void incrementQuantity() {
    quantity <= 50 ? quantity++ : null;
    emit(IncrementQuantityProductState());
  }

  void decrementQuantity() {
    quantity > 1 ? quantity-- : null;
    emit(DecrementQuantityProductState());
  }

  void addProductToCart() {
    int index = _box.values.toList().indexWhere((element) {
      return element["id"] == id;
    });

    if (index > -1) {
      var product = _box.getAt(index);
      product!["quantity"] = product["quantity"] + quantity;
      _box.putAt(index, product);
    } else {
      _box.add({"id": id, "quantity": quantity});
    }
    emit(AddedProductToCartState());
  }

  Future<void> addRemoveFavorite() async {
    productModel!.favorite = !productModel!.favorite;

    await DioHelper.postData(
      path: FAVORITE + productModel!.id.toString(),
      token: _token,
    ).then((response) {
      print(response.statusCode);
      emit(UpdateFavoriteProductState());
    }).catchError((error) {
      productModel!.favorite = !productModel!.favorite;

      print(error);
      emit(ErrorProductState());
    });
  }
}
