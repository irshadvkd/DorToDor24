import 'dart:convert';

List<GovernorateModal> governorateModalFromJson(String str) =>
    List<GovernorateModal>.from(
        json.decode(str).map((x) => GovernorateModal.fromJson(x)));

String governorateModalToJson(List<GovernorateModal> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class GovernorateModal {
  GovernorateModal({
    this.id,
    this.nameEng,
    this.nameAr,
  });

  GovernorateModal.fromJson(dynamic json) {
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
