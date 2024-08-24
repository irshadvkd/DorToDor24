import 'dart:convert';

/// status : 0
/// user_id : "1"
/// store_id : "1"
/// amount : 0
/// payment_type : 1
/// building : "New"
/// address : "Test"
/// contact : "123456789"
/// note : "Test Bite"
/// updated_at : "2024-08-24T00:30:13.000000Z"
/// created_at : "2024-08-24T00:30:13.000000Z"
/// id : 6

OrderModal orderModalFromJson(String str) =>
    OrderModal.fromJson(json.decode(str));
String orderModalToJson(OrderModal data) => json.encode(data.toJson());

class OrderModal {
  OrderModal({
    this.status,
    this.userId,
    this.storeId,
    this.amount,
    this.paymentType,
    this.building,
    this.address,
    this.contact,
    this.note,
    this.updatedAt,
    this.createdAt,
    this.id,
  });

  OrderModal.fromJson(dynamic json) {
    status = json['status'];
    userId = json['user_id'];
    storeId = json['store_id'];
    amount = json['amount'];
    paymentType = json['payment_type'];
    building = json['building'];
    address = json['address'];
    contact = json['contact'];
    note = json['note'];
    updatedAt = json['updated_at'];
    createdAt = json['created_at'];
    id = json['id'];
  }
  int? status;
  String? userId;
  String? storeId;
  int? amount;
  int? paymentType;
  String? building;
  String? address;
  String? contact;
  String? note;
  String? updatedAt;
  String? createdAt;
  int? id;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = status;
    map['user_id'] = userId;
    map['store_id'] = storeId;
    map['amount'] = amount;
    map['payment_type'] = paymentType;
    map['building'] = building;
    map['address'] = address;
    map['contact'] = contact;
    map['note'] = note;
    map['updated_at'] = updatedAt;
    map['created_at'] = createdAt;
    map['id'] = id;
    return map;
  }
}
