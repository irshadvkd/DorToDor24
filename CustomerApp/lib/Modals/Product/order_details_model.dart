// To parse this JSON data, do
//
//     final orderDetailsModel = orderDetailsModelFromJson(jsonString);

import 'dart:convert';

OrderDetailsModel orderDetailsModelFromJson(String str) => OrderDetailsModel.fromJson(json.decode(str));

String orderDetailsModelToJson(OrderDetailsModel data) => json.encode(data.toJson());

class OrderDetailsModel {
  final Data? data;
  final List<Product>? products;

  OrderDetailsModel({
    this.data,
    this.products,
  });

  factory OrderDetailsModel.fromJson(Map<String, dynamic> json) => OrderDetailsModel(
    data: json["data"] == null ? null : Data.fromJson(json["data"]),
    products: json["products"] == null ? [] : List<Product>.from(json["products"]!.map((x) => Product.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "data": data?.toJson(),
    "products": products == null ? [] : List<dynamic>.from(products!.map((x) => x.toJson())),
  };
}

class Data {
  final int? id;
  final int? status;
  final String? userName;
  final String? storeName;
  final String? amount;
  final DateTime? createdAt;
  final String? address;
  final String? contact;

  Data({
    this.id,
    this.status,
    this.userName,
    this.storeName,
    this.amount,
    this.createdAt,
    this.address,
    this.contact,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    id: json["id"],
    status: json["status"],
    userName: json["user_name"],
    storeName: json["store_name"],
    amount: json["amount"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    address: json["address"],
    contact: json["contact"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "status": status,
    "user_name": userName,
    "store_name": storeName,
    "amount": amount,
    "created_at": createdAt?.toIso8601String(),
    "address": address,
    "contact": contact,
  };
}

class Product {
  final int? id;
  final int? productId;
  final String? proPrice;
  final int? proQty;
  final String? nameEng;
  final String? nameAr;
  final String? image;
  final String? unitEng;
  final String? unitAr;

  Product({
    this.id,
    this.productId,
    this.proPrice,
    this.proQty,
    this.nameEng,
    this.nameAr,
    this.image,
    this.unitEng,
    this.unitAr,
  });

  factory Product.fromJson(Map<String, dynamic> json) => Product(
    id: json["id"],
    productId: json["product_id"],
    proPrice: json["pro_price"],
    proQty: json["pro_qty"],
    nameEng: json["name_eng"],
    nameAr: json["name_ar"],
    image: json["image"],
    unitEng: json["unit_eng"],
    unitAr: json["unit_ar"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "product_id": productId,
    "pro_price": proPrice,
    "pro_qty": proQty,
    "name_eng": nameEng,
    "name_ar": nameAr,
    "image": image,
    "unit_eng": unitEng,
    "unit_ar": unitAr,
  };
}
