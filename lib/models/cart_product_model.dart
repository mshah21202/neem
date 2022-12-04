import 'package:neem/models/product_model.dart';

class CartProductModel extends ProductModel {
  int quantity = 1;
  CartProductModel(ProductModel productModel, {this.quantity = 1})
      : super(
          id: productModel.id,
          name: productModel.name,
          description: productModel.description,
          price: productModel.price,
          photoUrls: productModel.photoUrls,
          category: productModel.category,
          favorite: productModel.favorite,
        );
}
