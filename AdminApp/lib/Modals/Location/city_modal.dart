import 'dart:convert';

List<CityModal> cityModalFromJson(String str) =>
    List<CityModal>.from(json.decode(str).map((x) => CityModal.fromJson(x)));

String cityModalToJson(List<CityModal> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class CityModal {
  CityModal({
    this.id,
    this.nameEng,
    this.nameAr,
  });

  CityModal.fromJson(dynamic json) {
    id = json['id'];
    nameEng = json['name_eng'];
    nameAr = json['name_ar'];
  }
  int? id;
  String? nameEng;
  String? nameAr;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name_eng'] = nameEng;
    map['name_ar'] = nameAr;
    return map;
  }
}
