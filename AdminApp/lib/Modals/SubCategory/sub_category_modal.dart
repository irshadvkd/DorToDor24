import 'dart:convert';

List<SubCategoryModal> subCategoryModalFromJson(String str) =>
    List<SubCategoryModal>.from(
        json.decode(str).map((x) => SubCategoryModal.fromJson(x)));

String subCategoryModalToJson(List<SubCategoryModal> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class SubCategoryModal {
  SubCategoryModal({
    this.id,
    this.nameEng,
    this.nameAr,
    this.image,
  });

  SubCategoryModal.fromJson(dynamic json) {
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
