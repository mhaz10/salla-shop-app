class FavoritesModel {
  final bool status;
  final FavoritesData? favoritesData;

  FavoritesModel({
    required this.status,
    this.favoritesData,
  });

  factory FavoritesModel.fromJson(Map<String, dynamic> json) {
    return FavoritesModel(
      status: json['status'] ?? false,
      favoritesData: json['data'] != null
          ? FavoritesData.fromJson(json['data'])
          : null,
    );
  }
}

class FavoritesData {
  final List<Data> data;

  FavoritesData({
    required this.data,
  });

  factory FavoritesData.fromJson(Map<String, dynamic> json) {
    return FavoritesData(
      data: (json['data'] as List? ?? [])
          .map((item) => Data.fromJson(item))
          .toList(),
    );
  }
}

class Data {
  final int id;
  final Product? product;

  Data({
    required this.id,
    this.product,
  });

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      id: json['id'] ?? 0,
      product: json['product'] != null
          ? Product.fromJson(json['product'])
          : null,
    );
  }
}

class Product {
  final int id;
  final int price;
  final int oldPrice;
  final int discount;
  final String image;
  final String name;
  final String description;

  Product({
    required this.id,
    required this.price,
    required this.oldPrice,
    required this.discount,
    required this.image,
    required this.name,
    required this.description,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'] ?? 0,
      price: json['price'] ?? 0,
      oldPrice: json['old_price'] ?? 0,
      discount: json['discount'] ?? 0,
      image: json['image'] ?? '',
      name: json['name'] ?? '',
      description: json['description'] ?? '',
    );
  }
}
