// To parse this JSON data, do
//
//     final productsModel = productsModelFromJson(jsonString);

import 'dart:convert';

ProductsModel productsModelFromJson(String str) => ProductsModel.fromJson(json.decode(str));

String productsModelToJson(ProductsModel data) => json.encode(data.toJson());

class ProductsModel {
  final bool? success;
  final int? code;
  final List<Product>? products;

  ProductsModel({
    this.success,
    this.code,
    this.products,
  });

  ProductsModel copyWith({
    bool? success,
    int? code,
    List<Product>? products,
  }) =>
      ProductsModel(
        success: success ?? this.success,
        code: code ?? this.code,
        products: products ?? this.products,
      );

  factory ProductsModel.fromJson(Map<String, dynamic> json) => ProductsModel(
    success: json["success"],
    code: json["code"],
    products: json["data"] == null ? [] : List<Product>.from(json["data"]!.map((x) => Product.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "code": code,
    "data": products == null ? [] : List<dynamic>.from(products!.map((x) => x.toJson())),
  };
}

class Product {
  final int? id;
  final String? name;
  final String? description;
  final String? photoPath;
  final dynamic categoryId;
  final String? number;
  final String? price;
  final String type;

  Product({
    this.id,
    this.name,
    this.description,
    this.photoPath,
    this.categoryId,
    this.number,
    this.price,
    required this.type,
  });

  Product copyWith({
    int? id,
    String? name,
    String? description,
    String? photoPath,
    String? type,
    dynamic categoryId,
    String? number,
    String? price,
  }) =>
      Product(
        id: id ?? this.id,
        name: name ?? this.name,
        type: type ?? this.type,
        description: description ?? this.description,
        photoPath: photoPath ?? this.photoPath,
        categoryId: categoryId ?? this.categoryId,
        number: number ?? this.number,
        price: price ?? this.price,
      );

  factory Product.fromJson(Map<String, dynamic> json) => Product(
    id: json["id"],
    name: json["name"],
    description: json["description"],
    photoPath: json["photo_path"],
    categoryId: json["category_id"],
    type: json["type"],
    number: json["number"],
    price: json["price"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "description": description,
    "photo_path": photoPath,
    "category_id": categoryId,
    "number": number,
    "price": price,
  };
}
