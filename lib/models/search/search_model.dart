class SearchModel {
  bool? status;
  SearchData? searchData;

  SearchModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    searchData = json['data'] != null ? SearchData.fromJson(json['data']) : null;
  }
}

class SearchData {
  List<Product> data = [];

  SearchData.fromJson(Map<String, dynamic> json) {

    if(json['data'] != null) {
      (json['data'] as List).forEach((product) => data.add(Product.fromJson(product)));
    }

  }
}

class Product {
  int? id;
  dynamic price;
  String? image;
  String? name;
  bool? inFavorites;

  Product.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    price = json['price'];
    image = json['image'];
    name = json['name'];
    inFavorites = json['in_favorites'];
  }
}

