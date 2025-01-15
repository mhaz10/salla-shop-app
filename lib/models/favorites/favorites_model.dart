class FavoritesModel {
   bool? status;
   FavoritesData? favoritesData;

   FavoritesModel.fromJson(Map<String, dynamic> json) {
      status =  json['status'];
     favoritesData = json['data'] != null ? FavoritesData.fromJson(json['data']): null;
  }
}

class FavoritesData {
  List<Data> data = [];

  FavoritesData.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      (json['data'] as List).forEach((element) => data.add(Data.fromJson(element)));
    }
  }
}

class Data {
   int? id;
   Product? product;

   Data.fromJson(Map<String, dynamic> json) {
      id = json['id'];
      product = json['product'] != null ? Product.fromJson(json['product']) : null;
  }
}

class Product {
  int? id;
  dynamic price;
  dynamic oldPrice;
  int? discount;
  String? image;
  String? name;
  bool? inFavorites;

  Product.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    price = json['price'];
    oldPrice = json['old_price'];
    discount = json['discount'];
    image = json['image'];
    name = json['name'];
    inFavorites = json['in_favorites'];
  }
}
