import 'dart:convert';

/// data : [{"id":1,"cat_id":1,"sub_cat_id":1,"name_eng":"Indian Green Chilli","name_ar":"الفلفل الأخضر الهندي","image":"/public/product/0sKEz8vwaykJbLZx17dLr1G6EOK2WZ.png","price":"7.499","unit_eng":"Pack","unit_ar":"علية","desc_eng":"Green chillies are a common vegetable used in Indian kitchens for their spicy taste. Green chillies are scientifically known as Capsicum frutescens. The spiciness of green chillies comes from a chemical called capsaicin.","desc_ar":"الفلفل الأخضر من الخضروات الشائعة المستخدمة في المطابخ الهندية لمذاقها الحار. يعرف الفلفل الأخضر علمياً باسم Capsicum frutescens. تأتي نكهة الفلفل الأخضر الحار من مادة كيميائية تسمى الكابسيسين."},{"id":2,"cat_id":1,"sub_cat_id":1,"name_eng":"Tomato","name_ar":"طماطم","image":"/public/product/cIuh5qPsNXdBHrLHOWXoghNb9eIETF.png","price":"6.000","unit_eng":"Pack","unit_ar":"علية","desc_eng":"The tomato fruit is globular or ovoid. Botanically, the fruit exhibits all of the common characteristics of berries; a simple fleshy fruit that encloses its seed in the pulp. The outer skin is a thin and fleshy tissue that comprises the remainder of the fruit wall as well as the placenta.","desc_ar":"ثمار الطماطم كروية أو بيضاوية. من الناحية النباتية، تُظهر الفاكهة جميع الخصائص المشتركة للتوت؛ فاكهة لحمية بسيطة تغلف بذورها في اللب. الجلد الخارجي عبارة عن نسيج رقيق ولحمي يشتمل على ما تبقى من جدار الفاكهة بالإضافة إلى المشيمة."},{"id":5,"cat_id":1,"sub_cat_id":1,"name_eng":"Carrot","name_ar":"جزرة","image":"/public/product/tLvBrIMEhbuVgDBIzMI2KjYf1q6Ge0.png","price":"4","unit_eng":"Box","unit_ar":"صندوق","desc_eng":"Carrot is a biennial, belonging to the family Apiaceae, and is an important vegetable for its fleshy edible, colorful roots. It varies in colour from white, yellow, orange, light purple, deep red to deep violet.","desc_ar":"الجزر هو نبات ثنائي الحول ينتمي إلى عائلة Apiaceae، وهو نبات مهم لجذوره الملونة الصالحة للأكل. ويتنوع لونه من الأبيض والأصفر والبرتقالي والأرجواني الفاتح والأحمر العميق إلى البنفسجي العميق."}]

ProductModal productModalFromJson(String str) =>
    ProductModal.fromJson(json.decode(str));
String productModalToJson(ProductModal data) => json.encode(data.toJson());

class ProductModal {
  ProductModal({
    this.data,
  });

  ProductModal.fromJson(dynamic json) {
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

/// id : 1
/// cat_id : 1
/// sub_cat_id : 1
/// name_eng : "Indian Green Chilli"
/// name_ar : "الفلفل الأخضر الهندي"
/// image : "/public/product/0sKEz8vwaykJbLZx17dLr1G6EOK2WZ.png"
/// price : "7.499"
/// unit_eng : "Pack"
/// unit_ar : "علية"
/// desc_eng : "Green chillies are a common vegetable used in Indian kitchens for their spicy taste. Green chillies are scientifically known as Capsicum frutescens. The spiciness of green chillies comes from a chemical called capsaicin."
/// desc_ar : "الفلفل الأخضر من الخضروات الشائعة المستخدمة في المطابخ الهندية لمذاقها الحار. يعرف الفلفل الأخضر علمياً باسم Capsicum frutescens. تأتي نكهة الفلفل الأخضر الحار من مادة كيميائية تسمى الكابسيسين."

Data dataFromJson(String str) => Data.fromJson(json.decode(str));
String dataToJson(Data data) => json.encode(data.toJson());

class Data {
  Data({
    this.id,
    this.catId,
    this.subCatId,
    this.nameEng,
    this.nameAr,
    this.image,
    this.price,
    this.unitEng,
    this.unitAr,
    this.descEng,
    this.descAr,
  });

  Data.fromJson(dynamic json) {
    id = json['id'];
    catId = json['cat_id'];
    subCatId = json['sub_cat_id'];
    nameEng = json['name_eng'];
    nameAr = json['name_ar'];
    image = json['image'];
    price = json['price'];
    unitEng = json['unit_eng'];
    unitAr = json['unit_ar'];
    descEng = json['desc_eng'];
    descAr = json['desc_ar'];
  }
  int? id;
  int? catId;
  int? subCatId;
  String? nameEng;
  String? nameAr;
  String? image;
  String? price;
  String? unitEng;
  String? unitAr;
  String? descEng;
  String? descAr;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['cat_id'] = catId;
    map['sub_cat_id'] = subCatId;
    map['name_eng'] = nameEng;
    map['name_ar'] = nameAr;
    map['image'] = image;
    map['price'] = price;
    map['unit_eng'] = unitEng;
    map['unit_ar'] = unitAr;
    map['desc_eng'] = descEng;
    map['desc_ar'] = descAr;
    return map;
  }
}
