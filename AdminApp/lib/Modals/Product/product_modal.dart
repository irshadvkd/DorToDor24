import 'dart:convert';

List<ProductModal> productModalFromJson(String str) => List<ProductModal>.from(
    json.decode(str).map((x) => ProductModal.fromJson(x)));

String productModalToJson(List<ProductModal> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ProductModal {
  ProductModal({
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

  ProductModal.fromJson(dynamic json) {
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
