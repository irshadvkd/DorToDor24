import 'dart:convert';
/// user : {"id":18,"status":0,"active_status":0,"name":"1","email":"1@gmail.com","previlage":2,"phone":"1","gov_id":null,"city_id":null,"block_id":null,"disable_product":null,"email_verified_at":null,"created_at":"2024-10-05T00:51:28.000000Z","updated_at":"2024-10-05T00:51:28.000000Z"}
/// token : "182|4E5bS57DjRZDRz6D7nNSWmgPdr1HnOGhyev4CfFO"

LoginModal loginModalFromJson(String str) => LoginModal.fromJson(json.decode(str));
String loginModalToJson(LoginModal data) => json.encode(data.toJson());
class LoginModal {
  LoginModal({
      this.user, 
      this.token,});

  LoginModal.fromJson(dynamic json) {
    user = json['user'] != null ? User.fromJson(json['user']) : null;
    token = json['token'];
  }
  User? user;
  String? token;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (user != null) {
      map['user'] = user?.toJson();
    }
    map['token'] = token;
    return map;
  }

}

/// id : 18
/// status : 0
/// active_status : 0
/// name : "1"
/// email : "1@gmail.com"
/// previlage : 2
/// phone : "1"
/// gov_id : null
/// city_id : null
/// block_id : null
/// disable_product : null
/// email_verified_at : null
/// created_at : "2024-10-05T00:51:28.000000Z"
/// updated_at : "2024-10-05T00:51:28.000000Z"

User userFromJson(String str) => User.fromJson(json.decode(str));
String userToJson(User data) => json.encode(data.toJson());
class User {
  User({
      this.id, 
      this.status, 
      this.activeStatus, 
      this.name, 
      this.email, 
      this.previlage, 
      this.phone, 
      this.govId, 
      this.cityId, 
      this.blockId, 
      this.disableProduct, 
      this.emailVerifiedAt, 
      this.createdAt, 
      this.updatedAt,});

  User.fromJson(dynamic json) {
    id = json['id'];
    status = json['status'];
    activeStatus = json['active_status'];
    name = json['name'];
    email = json['email'];
    previlage = json['previlage'];
    phone = json['phone'];
    govId = json['gov_id'];
    cityId = json['city_id'];
    blockId = json['block_id'];
    disableProduct = json['disable_product'];
    emailVerifiedAt = json['email_verified_at'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }
  int? id;
  int? status;
  int? activeStatus;
  String? name;
  String? email;
  int? previlage;
  String? phone;
  dynamic govId;
  dynamic cityId;
  dynamic blockId;
  dynamic disableProduct;
  dynamic emailVerifiedAt;
  String? createdAt;
  String? updatedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['status'] = status;
    map['active_status'] = activeStatus;
    map['name'] = name;
    map['email'] = email;
    map['previlage'] = previlage;
    map['phone'] = phone;
    map['gov_id'] = govId;
    map['city_id'] = cityId;
    map['block_id'] = blockId;
    map['disable_product'] = disableProduct;
    map['email_verified_at'] = emailVerifiedAt;
    map['created_at'] = createdAt;
    map['updated_at'] = updatedAt;
    return map;
  }

}