import 'dart:convert';

List<CategoryModal> categoryModalFromJson(String str) =>
    List<CategoryModal>.from(
        json.decode(str).map((x) => CategoryModal.fromJson(x)));

String categoryModalToJson(List<CategoryModal> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class CategoryModal {
  CategoryModal({
    this.id,
    this.nameEng,
    this.nameAr,
    this.image,
  });

  CategoryModal.fromJson(dynamic json) {
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
