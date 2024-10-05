import 'dart:convert';

/// data : [{"id":4,"product_id":2,"pro_qty":2,"name_eng":"Tomato","name_ar":"طماطم","image":"/public/product/cIuh5qPsNXdBHrLHOWXoghNb9eIETF.png","price":"6.000","unit_eng":"Pack","unit_ar":"علية"},{"id":5,"product_id":5,"pro_qty":2,"name_eng":"Carrot","name_ar":"جزرة","image":"/public/product/tLvBrIMEhbuVgDBIzMI2KjYf1q6Ge0.png","price":"4","unit_eng":"Box","unit_ar":"صندوق"},{"id":6,"product_id":1,"pro_qty":2,"name_eng":"Indian Green Chilli","name_ar":"الفلفل الأخضر الهندي","image":"/public/product/0sKEz8vwaykJbLZx17dLr1G6EOK2WZ.png","price":"7.499","unit_eng":"Pack","unit_ar":"علية"}]

CartModal cartModalFromJson(String str) => CartModal.fromJson(json.decode(str));
String cartModalToJson(CartModal data) => json.encode(data.toJson());

class CartModal {
  CartModal({
    this.data,
  });

  CartModal.fromJson(dynamic json) {
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data?.add(Data.fromJson(v));
      });
    }
  }
  List<Data>? data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (data != null) {
      map['data'] = data?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

/// id : 4
/// product_id : 2
/// pro_qty : 2
/// name_eng : "Tomato"
/// name_ar : "طماطم"
/// image : "/public/product/cIuh5qPsNXdBHrLHOWXoghNb9eIETF.png"
/// price : "6.000"
/// unit_eng : "Pack"
/// unit_ar : "علية"

Data dataFromJson(String str) => Data.fromJson(json.decode(str));
String dataToJson(Data data) => json.encode(data.toJson());

class Data {
  Data({
    this.id,
    this.productId,
    this.proQty,
    this.nameEng,
    this.nameAr,
    this.image,
    this.price,
    this.unitEng,
    this.unitAr,
  });

  Data.fromJson(dynamic json) {
    id = json['id'];
    productId = json['product_id'];
    proQty = json['pro_qty'];
    nameEng = json['name_eng'];
    nameAr = json['name_ar'];
    image = json['image'];
    price = json['price'];
    unitEng = json['unit_eng'];
    unitAr = json['unit_ar'];
  }
  int? id;
  int? productId;
  int? proQty;
  String? nameEng;
  String? nameAr;
  String? image;
  String? price;
  String? unitEng;
  String? unitAr;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['product_id'] = productId;
    map['pro_qty'] = proQty;
    map['name_eng'] = nameEng;
    map['name_ar'] = nameAr;
    map['image'] = image;
    map['price'] = price;
    map['unit_eng'] = unitEng;
    map['unit_ar'] = unitAr;
    return map;
  }
}
