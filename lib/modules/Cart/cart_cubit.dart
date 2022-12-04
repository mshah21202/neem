import 'dart:ffi';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:neem/models/order_model.dart';
import 'package:neem/models/product_model.dart';
import 'package:neem/modules/Cart/cart_states.dart';
import 'package:neem/modules/OrderDetails/order_details_screen.dart';
import 'package:neem/services/network/dio_helper.dart';
import 'package:neem/services/network/endpoints.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CartCubit extends Cubit<CartStates> {
  CartCubit() : super(InitialCartState()) {
    _openBox().then((value) {
      loadCartProducts();
    });
  }

  static CartCubit get(BuildContext context) => BlocProvider.of(context);

  late Box<Map<dynamic, dynamic>> _box;

  List<ProductModel> cartProducts = [];
  List<int> quantities = [];
  double subTotal = 0;
  int workingIndex = 0;
  OrderModel? result;

  Future<void> _openBox() async {
    _box = await Hive.openBox<Map<dynamic, dynamic>>("cart");
    // _box.add({"id" : 18, "quantity" : 1});
  }

  void loadCartProducts() async {
    List<int> productIds = [];
    for (int i = 0; i < _box.length; i++) {
      productIds.add(_box.getAt(i)!["id"]!);
      quantities.add(_box.getAt(i)!["quantity"]!);
    }
    emit(LoadingCartProductsState());
    DioHelper.getData(path: CART, query: {"id": productIds}).then((response) {
      for (var p in response.data) {
        ProductModel product = ProductModel.fromJson(p);
        cartProducts.add(product);
      }
      calculateSubTotal();
      emit(LoadedCartProductsState());
    }).catchError((error) {
      print(error);
      emit(ErrorOrderState());
    });
  }

  void deleteProduct(int index) {
    cartProducts.removeAt(index);
    quantities.removeAt(index);
    _box.deleteAt(index);
    calculateSubTotal();
    emit(DeletedProductState());
  }

  void calculateSubTotal() {
    subTotal = 0;
    for (int i = 0; i < cartProducts.length; i++) {
      subTotal += cartProducts[i].price * quantities[i];
    }
  }

  void incrementQuantity(int index) {
    quantities[index] <= 50 ? quantities[index]++ : null;
    var product = _box.getAt(index);
    product!["quantity"] = product["quantity"] + 1;
    _box.putAt(index, product);
    calculateSubTotal();
    emit(UpdateQuantityState());
  }

  void decrementQuantity(int index) {
    if (quantities[index] == 1) {
      workingIndex = index;
      emit(ConfirmDeleteProduct());
      return;
    }
    quantities[index] > 1 ? quantities[index]-- : null;
    var product = _box.getAt(index);
    product!["quantity"] = product["quantity"] - 1;
    _box.putAt(index, product);
    calculateSubTotal();
    emit(UpdateQuantityState());
  }

  void createOrder() async {
    emit(CreatingOrderState());
    List<Map<String, int>> products = [];
    for (int i = 0; i < cartProducts.length; i++) {
      products.add({"id": cartProducts[i].id, "quantity": quantities[i]});
    }
    await DioHelper.postData(
      path: ORDER,
      token: (await SharedPreferences.getInstance()).getString("token") ?? "",
      body: {
        "products": products,
      },
    ).then((response) {
      result = OrderModel.fromJson(response.data);
      _box.clear();
      emit(CreatedOrderState());
    });
  }
}
