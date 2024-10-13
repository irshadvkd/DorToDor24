import 'dart:convert';

List<StoreModal> storeModalFromJson(String str) =>
    List<StoreModal>.from(json.decode(str).map((x) => StoreModal.fromJson(x)));

String storeModalToJson(List<StoreModal> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class StoreModal {
  StoreModal({
    this.id,
    this.activeStatus,
    this.name,
    this.phone,
    this.govId,
    this.cityId,
    this.blockId,
  });

  StoreModal.fromJson(dynamic json) {
    id = json['id'];
    activeStatus = json['active_status'];
    name = json['name'];
    phone = json['phone'];
    govId = json['gov_id'];
    cityId = json['city_id'];
    blockId = json['block_id'];
  }
  int? id;
  int? activeStatus;
  String? name;
  String? phone;
  int? govId;
  int? cityId;
  int? blockId;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['active_status'] = activeStatus;
    map['name'] = name;
    map['phone'] = phone;
    map['gov_id'] = govId;
    map['city_id'] = cityId;
    map['block_id'] = blockId;
    return map;
  }
}
