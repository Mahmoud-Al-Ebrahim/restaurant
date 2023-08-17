// To parse this JSON data, do
//
//     final tablesModel = tablesModelFromJson(jsonString);

import 'dart:convert';

import 'package:restaurant/models/products_model.dart';

TablesModel tablesModelFromJson(String str) => TablesModel.fromJson(json.decode(str));

String tablesModelToJson(TablesModel data) => json.encode(data.toJson());

class TablesModel {
  final bool? success;
  final int? code;
  final List<Table>? tables;

  TablesModel({
    this.success,
    this.code,
    this.tables,
  });

  TablesModel copyWith({
    bool? success,
    int? code,
    List<Table>? tables,
  }) =>
      TablesModel(
        success: success ?? this.success,
        code: code ?? this.code,
        tables: tables ?? this.tables,
      );

  factory TablesModel.fromJson(Map<String, dynamic> json) => TablesModel(
    success: json["success"],
    code: json["code"],
    tables: json["data"] == null ? [] : List<Table>.from(json["data"]!.map((x) => Table.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "code": code,
    "data": tables == null ? [] : List<dynamic>.from(tables!.map((x) => x.toJson())),
  };
}

class Table {
  final int? id;
  final String? name;
  final String? number;
  final String? location;
  final int? isReserved;
  final ActiveOrder? activeOrder;

  Table({
    this.id,
    this.name,
    this.number,
    this.location,
    this.isReserved,
    this.activeOrder,
  });

  Table copyWith({
    int? id,
    String? name,
    String? number,
    String? location,
    int? isReserved,
    ActiveOrder? activeOrder,
  }) =>
      Table(
        id: id ?? this.id,
        name: name ?? this.name,
        number: number ?? this.number,
        location: location ?? this.location,
        isReserved: isReserved ?? this.isReserved,
        activeOrder: activeOrder ?? this.activeOrder,
      );

  factory Table.fromJson(Map<String, dynamic> json) => Table(
    id: json["id"],
    name: json["name"],
    number: json["number"],
    location: json["location"],
    isReserved: json["is_reserved"],
    activeOrder: json["active_order"] == null ? null : ActiveOrder.fromJson(json["active_order"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "number": number,
    "location": location,
    "is_reserved": isReserved,
    "active_order": activeOrder?.toJson(),
  };
}

class ActiveOrder {
  final int? id;
  final dynamic notes;
  final String? status;
  final int? tableId;
  final List<Cart>? carts;

  ActiveOrder({
    this.id,
    this.notes,
    this.status,
    this.tableId,
    this.carts,
  });

  ActiveOrder copyWith({
    int? id,
    dynamic notes,
    String? status,
    int? tableId,
    List<Cart>? carts,
  }) =>
      ActiveOrder(
        id: id ?? this.id,
        notes: notes ?? this.notes,
        status: status ?? this.status,
        tableId: tableId ?? this.tableId,
        carts: carts ?? this.carts,
      );

  factory ActiveOrder.fromJson(Map<String, dynamic> json) => ActiveOrder(
    id: json["id"],
    notes: json["notes"],
    status: json["status"],
    tableId: json["table_id"],
    carts: json["carts"] == null ? [] : List<Cart>.from(json["carts"]!.map((x) => Cart.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "notes": notes,
    "status": status,
    "table_id": tableId,
    "carts": carts == null ? [] : List<dynamic>.from(carts!.map((x) => x.toJson())),
  };
}

class Cart {
  final int? id;
  final int? productId;
  final int? orderId;
  final String? price;
  final int? amount;
  final String? notes;
  final Product? product;

  Cart({
    this.id,
    this.productId,
    this.orderId,
    this.price,
    this.amount,
    this.notes,
    this.product,
  });

  Cart copyWith({
    int? id,
    int? productId,
    int? orderId,
    String? price,
    int? amount,
    String? notes,
    Product? product,
  }) =>
      Cart(
        id: id ?? this.id,
        productId: productId ?? this.productId,
        orderId: orderId ?? this.orderId,
        price: price ?? this.price,
        amount: amount ?? this.amount,
        notes: notes ?? this.notes,
        product: product ?? this.product,
      );

  factory Cart.fromJson(Map<String, dynamic> json) => Cart(
    id: json["id"],
    productId: json["product_id"],
    orderId: json["order_id"],
    price: json["price"],
    amount: json["amount"],
    notes: json["notes"],
    product: json["product"] == null ? null : Product.fromJson(json["product"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "product_id": productId,
    "order_id": orderId,
    "price": price,
    "amount": amount,
    "notes": notes,
    "product": product?.toJson(),
  };
}
