import 'dart:convert';
/// status : true
/// slider : [{"id":1,"name":"Home 1","image":"/public/banner/hzpLSu1MVAQrHe9KAmZPbAS2QYFncx.png","type":0},{"id":2,"name":"Home 2","image":"/public/banner/d4LgReNpXm489nRSwMNpdNNwk0SuSz.png","type":1}]
/// category : [{"id":1,"name_eng":"Bakala","name_ar":"باكالا","image":"/public/category/mBXWrrMVHXVJTXTvJLjMme0HQjjEBj.png"},{"id":2,"name_eng":"Matham","name_ar":"ماثام","image":"/public/category/S7ZdnyuUC0cI1gOoUfdfCVifZMN65m.png"}]
/// cart : [{"id":6,"product_id":1,"pro_qty":4,"name_eng":"Indian Green Chilli","name_ar":"الفلفل الأخضر الهندي","image":"/public/product/0sKEz8vwaykJbLZx17dLr1G6EOK2WZ.png","price":"7.499","unit_eng":"Pack","unit_ar":"علية"}]

HomeModal homeModalFromJson(String str) => HomeModal.fromJson(json.decode(str));
String homeModalToJson(HomeModal data) => json.encode(data.toJson());
class HomeModal {
  HomeModal({
      this.status, 
      this.slider, 
      this.category, 
      this.cart,});

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
  }
  bool? status;
  List<Slider>? slider;
  List<Category>? category;
  List<Cart>? cart;

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
    return map;
  }

}

/// id : 6
/// product_id : 1
/// pro_qty : 4
/// name_eng : "Indian Green Chilli"
/// name_ar : "الفلفل الأخضر الهندي"
/// image : "/public/product/0sKEz8vwaykJbLZx17dLr1G6EOK2WZ.png"
/// price : "7.499"
/// unit_eng : "Pack"
/// unit_ar : "علية"

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
      this.unitAr,});

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
      this.image,});

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

/// id : 1
/// name : "Home 1"
/// image : "/public/banner/hzpLSu1MVAQrHe9KAmZPbAS2QYFncx.png"
/// type : 0

Slider sliderFromJson(String str) => Slider.fromJson(json.decode(str));
String sliderToJson(Slider data) => json.encode(data.toJson());
class Slider {
  Slider({
      this.id, 
      this.name, 
      this.image, 
      this.type,});

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