import 'package:neem/extensions/string_extension.dart';
import 'package:neem/models/product_model.dart';

enum OrderState {
  processing,
  delivering,
  delivered,
  refunded;

  @override
  String toString() => this.name.capitalize();
}

class OrderModel {
  int id;
  double total;
  List<ProductModel> products;
  OrderState orderState;
  List<int> quantities;

  OrderModel(
      {required this.id,
      required this.total,
      required this.products,
      required this.orderState,
      required this.quantities});

  factory OrderModel.fromJson(Map<String, dynamic> json) {
    List<ProductModel> products =
        (json["products"] as List<dynamic>).map<ProductModel>((e) {
      return ProductModel.fromJson(e);
    }).toList();
    List<int> quantities = (json["quantities"] as List<dynamic>).map<int>((e) {
      return e as int;
    }).toList();
    return OrderModel(
      id: json["id"],
      total: json["total"],
      products: products,
      orderState: OrderState.values[json["state"] as int],
      quantities: quantities,
    );
  }
}
