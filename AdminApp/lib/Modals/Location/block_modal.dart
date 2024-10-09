import 'dart:convert';

List<BlockModal> blockModalFromJson(String str) =>
    List<BlockModal>.from(json.decode(str).map((x) => BlockModal.fromJson(x)));

String blockModalToJson(List<BlockModal> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class BlockModal {
  BlockModal({
    this.id,
    this.nameEng,
    this.nameAr,
  });

  BlockModal.fromJson(dynamic json) {
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
