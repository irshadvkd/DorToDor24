import 'dart:convert';

/// status : true
/// slider : [{"id":3,"name":"M","image":"/public/banner/KtfokJAOdY2o1kJs686kEAC7avz8hr.png","type":0},{"id":4,"name":"M","image":"/public/banner/Ti7WqOCArg6uLrO5ALphJNUFSTcOPE.png","type":1},{"id":5,"name":"ت","image":"/public/banner/oCbMDG9LfRZtKR4O7oJiXHtrZITcC1.png","type":0},{"id":6,"name":"ت","image":"/public/banner/l6ygijGjkkA80do403eiGEyk6hzM0k.png","type":1}]
/// category : [{"id":1,"name_eng":"Bakala","name_ar":"باكالا","image":"/public/category/mBXWrrMVHXVJTXTvJLjMme0HQjjEBj.png"},{"id":2,"name_eng":"Matham","name_ar":"ماثام","image":"/public/category/S7ZdnyuUC0cI1gOoUfdfCVifZMN65m.png"}]
/// cart : [{"id":29,"product_id":5,"pro_qty":2,"name_eng":"Carrot","name_ar":"جزرة","image":"/public/product/tLvBrIMEhbuVgDBIzMI2KjYf1q6Ge0.png","price":"4","unit_eng":"Box","unit_ar":"صندوق"},{"id":32,"product_id":1,"pro_qty":2,"name_eng":"Indian Green Chilli","name_ar":"الفلفل الأخضر الهندي","image":"/public/product/0sKEz8vwaykJbLZx17dLr1G6EOK2WZ.png","price":"7.499","unit_eng":"Pack","unit_ar":"علية"}]
/// store : {"id":14,"status":0,"active_status":0,"name":"SABAH AL AHAMAD 1","email":"sabahalahmad1@gmail.com","previlage":2,"phone":"66478626","gov_id":1,"city_id":1,"block_id":1,"disable_product":null,"email_verified_at":null,"created_at":"2024-08-23T20:52:47.000000Z","updated_at":"2024-08-23T20:52:47.000000Z"}

HomeModal homeModalFromJson(String str) => HomeModal.fromJson(json.decode(str));
String homeModalToJson(HomeModal data) => json.encode(data.toJson());

class HomeModal {
  HomeModal({
    this.status,
    this.slider,
    this.category,
    this.cart,
    this.store,
  });

  HomeModal.fromJson(dynamic json) {
    status = json['status'];
    if (json['slider'] != null) {
      slider = [];
      json['slider'].forEach((v) {
        slider?.add(Slider.fromJson(v));
      });
    }
    if (json['category'] != null) {
      category = [];
      json['category'].forEach((v) {
        category?.add(Category.fromJson(v));
      });
    }
    if (json['cart'] != null) {
      cart = [];
      json['cart'].forEach((v) {
        cart?.add(Cart.fromJson(v));
      });
    }
    store = json['store'] != null ? Store.fromJson(json['store']) : null;
  }
  bool? status;
  List<Slider>? slider;
  List<Category>? category;
  List<Cart>? cart;
  Store? store;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = status;
    if (slider != null) {
      map['slider'] = slider?.map((v) => v.toJson()).toList();
    }
    if (category != null) {
      map['category'] = category?.map((v) => v.toJson()).toList();
    }
    if (cart != null) {
      map['cart'] = cart?.map((v) => v.toJson()).toList();
    }
    if (store != null) {
      map['store'] = store?.toJson();
    }
    return map;
  }
}

/// id : 14
/// status : 0
/// active_status : 0
/// name : "SABAH AL AHAMAD 1"
/// email : "sabahalahmad1@gmail.com"
/// previlage : 2
/// phone : "66478626"
/// gov_id : 1
/// city_id : 1
/// block_id : 1
/// disable_product : null
/// email_verified_at : null
/// created_at : "2024-08-23T20:52:47.000000Z"
/// updated_at : "2024-08-23T20:52:47.000000Z"

Store storeFromJson(String str) => Store.fromJson(json.decode(str));
String storeToJson(Store data) => json.encode(data.toJson());

class Store {
  Store({
    this.id,
    this.status,
    this.activeStatus,
    this.name,
    this.email,
    this.previlage,
    this.phone,
    this.govId,
    this.cityId,
    this.blockId,
    this.disableProduct,
    this.emailVerifiedAt,
    this.createdAt,
    this.updatedAt,
  });

  Store.fromJson(dynamic json) {
    id = json['id'];
    status = json['status'];
    activeStatus = json['active_status'];
    name = json['name'];
    email = json['email'];
    previlage = json['previlage'];
    phone = json['phone'];
    govId = json['gov_id'];
    cityId = json['city_id'];
    blockId = json['block_id'];
    disableProduct = json['disable_product'];
    emailVerifiedAt = json['email_verified_at'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }
  int? id;
  int? status;
  int? activeStatus;
  String? name;
  String? email;
  int? previlage;
  String? phone;
  int? govId;
  int? cityId;
  int? blockId;
  dynamic disableProduct;
  dynamic emailVerifiedAt;
  String? createdAt;
  String? updatedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['status'] = status;
    map['active_status'] = activeStatus;
    map['name'] = name;
    map['email'] = email;
    map['previlage'] = previlage;
    map['phone'] = phone;
    map['gov_id'] = govId;
    map['city_id'] = cityId;
    map['block_id'] = blockId;
    map['disable_product'] = disableProduct;
    map['email_verified_at'] = emailVerifiedAt;
    map['created_at'] = createdAt;
    map['updated_at'] = updatedAt;
    return map;
  }
}

/// id : 29
/// product_id : 5
/// pro_qty : 2
/// name_eng : "Carrot"
/// name_ar : "جزرة"
/// image : "/public/product/tLvBrIMEhbuVgDBIzMI2KjYf1q6Ge0.png"
/// price : "4"
/// unit_eng : "Box"
/// unit_ar : "صندوق"

Cart cartFromJson(String str) => Cart.fromJson(json.decode(str));
String cartToJson(Cart data) => json.encode(data.toJson());

class Cart {
  Cart({
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

  Cart.fromJson(dynamic json) {
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

/// id : 1
/// name_eng : "Bakala"
/// name_ar : "باكالا"
/// image : "/public/category/mBXWrrMVHXVJTXTvJLjMme0HQjjEBj.png"

Category categoryFromJson(String str) => Category.fromJson(json.decode(str));
String categoryToJson(Category data) => json.encode(data.toJson());

class Category {
  Category({
    this.id,
    this.nameEng,
    this.nameAr,
    this.image,
  });

  Category.fromJson(dynamic json) {
    id = json['id'];
    nameEng = json['name_eng'];
    nameAr = json['name_ar'];
    image = json['image'];
  }
  int? id;
  String? nameEng;
  String? nameAr;
  String? image;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name_eng'] = nameEng;
    map['name_ar'] = nameAr;
    map['image'] = image;
    return map;
  }
}

/// id : 3
/// name : "M"
/// image : "/public/banner/KtfokJAOdY2o1kJs686kEAC7avz8hr.png"
/// type : 0

Slider sliderFromJson(String str) => Slider.fromJson(json.decode(str));
String sliderToJson(Slider data) => json.encode(data.toJson());

class Slider {
  Slider({
    this.id,
    this.name,
    this.image,
    this.type,
  });

  Slider.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
    image = json['image'];
    type = json['type'];
  }
  int? id;
  String? name;
  String? image;
  int? type;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    map['image'] = image;
    map['type'] = type;
    return map;
  }
}
