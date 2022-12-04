import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neem/models/product_model.dart';
import 'package:neem/modules/OrderDetails/order_list_states.dart';
import 'package:neem/services/network/dio_helper.dart';
import 'package:neem/services/network/endpoints.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../models/order_model.dart';

class OrderListCubit extends Cubit<OrderListStates> {
  OrderListCubit() : super(InitialOrderListState()) {
    loadToken().then((value) {
      loadOrders();
    });
  }

  static OrderListCubit get(context) => BlocProvider.of(context);

  List<OrderModel> orderModels = [];
  String _token = "";

  Future<void> loadToken() async {
    var prefs = await SharedPreferences.getInstance();
    var token = prefs.getString("token");
    _token = token ?? "";
  }

  void loadOrders() {
    emit(LoadingOrdersState());
    DioHelper.getData(path: ORDER, token: _token).then((response) {
      for (Map<String, dynamic> x in response.data) {
        orderModels.add(OrderModel.fromJson(x));
      }
      emit(LoadedOrdersState());
    }).catchError((error) {
      emit(ErrorOrdersState());
      print(error);
    });
  }
}
