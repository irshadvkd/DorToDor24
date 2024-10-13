import 'dart:convert';
/// data : {"id":1,"status":0,"user_name":"TestUser","store_name":"New6","amount":"630","created_at":"2024-06-08T08:34:02.000000Z","address":"Test address delivery","contact":"0987654321"}
/// products : [{"id":1,"product_id":1,"pro_price":"7.499","pro_qty":4,"name_eng":"Indian Green Chilli","name_ar":"الفلفل الأخضر الهندي","image":"/public/product/0sKEz8vwaykJbLZx17dLr1G6EOK2WZ.png","unit_eng":"Pack","unit_ar":"علية"},{"id":2,"product_id":3,"pro_price":"312.000","pro_qty":4,"name_eng":"Green Apple","name_ar":"تفاحة خضراء","image":"/public/product/ePWQqGm4i4mLJY6Vm1Sdt3he9eKXHL.png","unit_eng":"Pack","unit_ar":"علية"}]

OrderDetailModal orderDetailModalFromJson(String str) => OrderDetailModal.fromJson(json.decode(str));
String orderDetailModalToJson(OrderDetailModal data) => json.encode(data.toJson());
class OrderDetailModal {
  OrderDetailModal({
      this.data, 
      this.products,});

  OrderDetailModal.fromJson(dynamic json) {
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
    if (json['products'] != null) {
      products = [];
      json['products'].forEach((v) {
        products?.add(Products.fromJson(v));
      });
    }
  }
  Data? data;
  List<Products>? products;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (data != null) {
      map['data'] = data?.toJson();
    }
    if (products != null) {
      map['products'] = products?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// id : 1
/// product_id : 1
/// pro_price : "7.499"
/// pro_qty : 4
/// name_eng : "Indian Green Chilli"
/// name_ar : "الفلفل الأخضر الهندي"
/// image : "/public/product/0sKEz8vwaykJbLZx17dLr1G6EOK2WZ.png"
/// unit_eng : "Pack"
/// unit_ar : "علية"

Products productsFromJson(String str) => Products.fromJson(json.decode(str));
String productsToJson(Products data) => json.encode(data.toJson());
class Products {
  Products({
      this.id, 
      this.productId, 
      this.proPrice, 
      this.proQty, 
      this.nameEng, 
      this.nameAr, 
      this.image, 
      this.unitEng, 
      this.unitAr,});

  Products.fromJson(dynamic json) {
    id = json['id'];
    productId = json['product_id'];
    proPrice = json['pro_price'];
    proQty = json['pro_qty'];
    nameEng = json['name_eng'];
    nameAr = json['name_ar'];
    image = json['image'];
    unitEng = json['unit_eng'];
    unitAr = json['unit_ar'];
  }
  int? id;
  int? productId;
  String? proPrice;
  int? proQty;
  String? nameEng;
  String? nameAr;
  String? image;
  String? unitEng;
  String? unitAr;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['product_id'] = productId;
    map['pro_price'] = proPrice;
    map['pro_qty'] = proQty;
    map['name_eng'] = nameEng;
    map['name_ar'] = nameAr;
    map['image'] = image;
    map['unit_eng'] = unitEng;
    map['unit_ar'] = unitAr;
    return map;
  }

}

/// id : 1
/// status : 0
/// user_name : "TestUser"
/// store_name : "New6"
/// amount : "630"
/// created_at : "2024-06-08T08:34:02.000000Z"
/// address : "Test address delivery"
/// contact : "0987654321"

Data dataFromJson(String str) => Data.fromJson(json.decode(str));
String dataToJson(Data data) => json.encode(data.toJson());
class Data {
  Data({
      this.id, 
      this.status, 
      this.userName, 
      this.storeName, 
      this.amount, 
      this.createdAt, 
      this.address, 
      this.contact,});

  Data.fromJson(dynamic json) {
    id = json['id'];
    status = json['status'];
    userName = json['user_name'];
    storeName = json['store_name'];
    amount = json['amount'];
    createdAt = json['created_at'];
    address = json['address'];
    contact = json['contact'];
  }
  int? id;
  int? status;
  String? userName;
  String? storeName;
  String? amount;
  String? createdAt;
  String? address;
  String? contact;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['status'] = status;
    map['user_name'] = userName;
    map['store_name'] = storeName;
    map['amount'] = amount;
    map['created_at'] = createdAt;
    map['address'] = address;
    map['contact'] = contact;
    return map;
  }

}