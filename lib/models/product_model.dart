class ProductModel {
  int id;
  String name;
  String description;
  double price;
  List<String> photoUrls;
  String category;
  bool favorite;

  ProductModel(
      {required this.id,
      required this.name,
      required this.description,
      required this.price,
      required this.photoUrls,
      required this.category,
      required this.favorite});
  factory ProductModel.fromJson(Map<String, dynamic> json) {
    List<dynamic> urls =
        json["photoUrl"] is String ? [json["photoUrl"]] : json["photoUrls"];
    return ProductModel(
      id: json["id"],
      name: json["name"],
      description: json["description"] ?? "",
      price: json["price"],
      photoUrls: urls.cast<String>(),
      category: json["category"] ?? "",
      favorite: json["isFavorite"] ?? false,
    );
  }

  @override
  bool operator ==(Object other) {
    if (other is ProductModel) {
      return other.id == id;
    }
    return false;
  }

  @override
  int get hashCode => id;
}
