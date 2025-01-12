class CategoryModel {
  bool? status;
  CategoryData? categoryData;

  CategoryModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    categoryData = CategoryData.fromJson(json['data']);
  }
}

class CategoryData {
  List<DataModel> data = [];
  
  CategoryData.fromJson(Map<String, dynamic> json) {
    (json['data'] as List).forEach((element) => data.add(DataModel.fromJson(element)));
  }
}

class DataModel {
  int? id;
  String? name;
  String? image;

  DataModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    image = json['image'];
  }
}