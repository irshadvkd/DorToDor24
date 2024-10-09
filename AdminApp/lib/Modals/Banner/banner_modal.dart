import 'dart:convert';

List<BannerModal> bannerModalFromJson(String str) => List<BannerModal>.from(
    json.decode(str).map((x) => BannerModal.fromJson(x)));

String bannerModalToJson(List<BannerModal> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class BannerModal {
  BannerModal({
    this.id,
    this.name,
    this.image,
    this.type,
  });

  BannerModal.fromJson(dynamic json) {
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
