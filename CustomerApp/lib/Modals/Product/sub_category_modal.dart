import 'dart:convert';

/// banner : [{"id":2,"name":"Home 2","image":"/public/banner/d4LgReNpXm489nRSwMNpdNNwk0SuSz.png","type":1}]
/// data : [{"id":1,"name_eng":"Vegetables","name_ar":"خضروات","image":"/public/subCategory/csp9x3bKvGB01LpA0CaT7VlfzluQ1v.png"},{"id":2,"name_eng":"Fruits","name_ar":"الفاكهة","image":"/public/subCategory/SgmTzZfyTDOqsmnLqBnw6TLnPgEM4w.png"}]

SubCategoryModal subCategoryModalFromJson(String str) =>
    SubCategoryModal.fromJson(json.decode(str));
String subCategoryModalToJson(SubCategoryModal data) =>
    json.encode(data.toJson());

class SubCategoryModal {
  SubCategoryModal({
    this.banner,
    this.data,
  });

  SubCategoryModal.fromJson(dynamic json) {
    if (json['banner'] != null) {
      banner = [];
      json['banner'].forEach((v) {
        banner?.add(Banner.fromJson(v));
      });
    }
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data?.add(Data.fromJson(v));
      });
    }
  }
  List<Banner>? banner;
  List<Data>? data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (banner != null) {
      map['banner'] = banner?.map((v) => v.toJson()).toList();
    }
    if (data != null) {
      map['data'] = data?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

/// id : 1
/// name_eng : "Vegetables"
/// name_ar : "خضروات"
/// image : "/public/subCategory/csp9x3bKvGB01LpA0CaT7VlfzluQ1v.png"

Data dataFromJson(String str) => Data.fromJson(json.decode(str));
String dataToJson(Data data) => json.encode(data.toJson());

class Data {
  Data({
    this.id,
    this.nameEng,
    this.nameAr,
    this.image,
  });

  Data.fromJson(dynamic json) {
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

/// id : 2
/// name : "Home 2"
/// image : "/public/banner/d4LgReNpXm489nRSwMNpdNNwk0SuSz.png"
/// type : 1

Banner bannerFromJson(String str) => Banner.fromJson(json.decode(str));
String bannerToJson(Banner data) => json.encode(data.toJson());

class Banner {
  Banner({
    this.id,
    this.name,
    this.image,
    this.type,
  });

  Banner.fromJson(dynamic json) {
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
