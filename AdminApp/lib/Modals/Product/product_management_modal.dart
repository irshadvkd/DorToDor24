import 'dart:convert';

/// data : [{"id":1,"name_eng":"Indian Green Chilli","name_ar":"الفلفل الأخضر الهندي","image":"/public/product/0sKEz8vwaykJbLZx17dLr1G6EOK2WZ.png","price":"7.499"},{"id":2,"name_eng":"Tomato","name_ar":"طماطم","image":"/public/product/cIuh5qPsNXdBHrLHOWXoghNb9eIETF.png","price":"6.000"},{"id":3,"name_eng":"Green Apple","name_ar":"تفاحة خضراء","image":"/public/product/ePWQqGm4i4mLJY6Vm1Sdt3he9eKXHL.png","price":"312.000"},{"id":4,"name_eng":"Fresh Fruit Juice","name_ar":"عصير فاكهة طازج","image":"/public/product/BdkM9VdjMxjDaxZF6zh3XIMHPz8Lrq.png","price":"6"},{"id":5,"name_eng":"Carrot","name_ar":"جزرة","image":"/public/product/tLvBrIMEhbuVgDBIzMI2KjYf1q6Ge0.png","price":"4"}]
/// disabled : [{"disable_product":null}]

ProductManagementModal productManagementModalFromJson(String str) =>
    ProductManagementModal.fromJson(json.decode(str));
String productManagementModalToJson(ProductManagementModal data) =>
    json.encode(data.toJson());

class ProductManagementModal {
  ProductManagementModal({
    this.data,
    this.disabled,
  });

  ProductManagementModal.fromJson(dynamic json) {
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data?.add(Data.fromJson(v));
      });
    }
    if (json['disabled'] != null) {
      disabled = [];
      json['disabled'].forEach((v) {
        disabled?.add(Disabled.fromJson(v));
      });
    }
  }
  List<Data>? data;
  List<Disabled>? disabled;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (data != null) {
      map['data'] = data?.map((v) => v.toJson()).toList();
    }
    if (disabled != null) {
      map['disabled'] = disabled?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

/// disable_product : null

Disabled disabledFromJson(String str) => Disabled.fromJson(json.decode(str));
String disabledToJson(Disabled data) => json.encode(data.toJson());

class Disabled {
  Disabled({
    this.disableProduct,
  });

  Disabled.fromJson(dynamic json) {
    disableProduct = json['disable_product'];
  }
  dynamic disableProduct;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['disable_product'] = disableProduct;
    return map;
  }
}

/// id : 1
/// name_eng : "Indian Green Chilli"
/// name_ar : "الفلفل الأخضر الهندي"
/// image : "/public/product/0sKEz8vwaykJbLZx17dLr1G6EOK2WZ.png"
/// price : "7.499"

Data dataFromJson(String str) => Data.fromJson(json.decode(str));
String dataToJson(Data data) => json.encode(data.toJson());

class Data {
  Data({
    this.id,
    this.nameEng,
    this.nameAr,
    this.image,
    this.price,
  });

  Data.fromJson(dynamic json) {
    id = json['id'];
    nameEng = json['name_eng'];
    nameAr = json['name_ar'];
    image = json['image'];
    price = json['price'];
  }
  int? id;
  String? nameEng;
  String? nameAr;
  String? image;
  String? price;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name_eng'] = nameEng;
    map['name_ar'] = nameAr;
    map['image'] = image;
    map['price'] = price;
    return map;
  }
}
