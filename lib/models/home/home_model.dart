  class HomeModel {
  bool? status;
  Data? data;

  HomeModel.fromJson (Map<String, dynamic> json) {
    status = json['status'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }}

  class Data {
  List<Banner> banners = [];
  List<Product> products = [];


  Data.fromJson(Map<String, dynamic> json) {

    if(json['banners'] != null) {
      (json['banners'] as List).forEach((banner) => banners.add(Banner.fromJson(banner)));
    }

    if(json['products'] != null) {
      (json['products'] as List).forEach((product) => products.add(Product.fromJson(product)));
    }

  }

  }

class Banner {
  int? id;
  String? image;

  Banner.fromJson(Map<String, dynamic>json) {
    id = json['id'];
    image = json['image'];
  }

}

class Product {
  int? id;
  dynamic price;
  dynamic oldPrice;
  dynamic discount;
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
