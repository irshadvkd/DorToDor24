import 'dart:convert';

/// id : 1
/// status : 0
/// user_name : "TestUser"
/// store_name : "New6"
/// amount : "630"
/// created_at : "2024-06-08T08:34:02.000000Z"

List<AdminOrderModal> orderModalFromJson(String str) =>
    List<AdminOrderModal>.from(json.decode(str).map((x) => AdminOrderModal.fromJson(x)));

String orderModalToJson(List<AdminOrderModal> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class AdminOrderModal {
  AdminOrderModal({
    this.id,
    this.status,
    this.userName,
    this.storeName,
    this.amount,
    this.createdAt,
  });

  AdminOrderModal.fromJson(dynamic json) {
    id = json['id'];
    status = json['status'];
    userName = json['user_name'];
    storeName = json['store_name'];
    amount = json['amount'];
    createdAt = json['created_at'];
  }
  int? id;
  int? status;
  String? userName;
  String? storeName;
  String? amount;
  String? createdAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['status'] = status;
    map['user_name'] = userName;
    map['store_name'] = storeName;
    map['amount'] = amount;
    map['created_at'] = createdAt;
    return map;
  }
}
