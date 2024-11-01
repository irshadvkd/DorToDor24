import 'dart:convert';

OrderModal orderModalFromJson(String str) =>
    OrderModal.fromJson(json.decode(str));
String orderModalToJson(OrderModal data) => json.encode(data.toJson());

class OrderModal {
  OrderModal({
    required this.orders, // Renamed to orders
  });

  OrderModal.fromJson(dynamic json) {
    // Expecting a list of orders directly
    if (json is List) {
      orders = json.map((order) => Order.fromJson(order)).toList();
    }
  }

  List<Order> orders = []; // List of Order objects

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['orders'] = orders.map((order) => order.toJson()).toList();
    return map;
  }
}

class Order {
  Order({
    this.id,
    this.status,
    this.storeName,
    this.amount,
    this.createdAt,
  });

  Order.fromJson(dynamic json) {
    id = json['id'];
    status = json['status'];
    storeName = json['store_name'];
    amount = json['amount'];
    createdAt = json['created_at'];
  }

  int? id;
  int? status;
  String? storeName;
  String? amount;
  String? createdAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['status'] = status;
    map['store_name'] = storeName;
    map['amount'] = amount;
    map['created_at'] = createdAt;
    return map;
  }
}
