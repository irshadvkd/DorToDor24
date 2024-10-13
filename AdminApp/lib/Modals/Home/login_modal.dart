import 'dart:convert';

/// user : {"id":1,"status":0,"name":"Admin","email":"admin@gmail.com","previlage":1,"email_verified_at":null,"created_at":null,"updated_at":"2024-04-19T12:41:36.000000Z"}
/// token : "26|WgnRPmDt6p3kY1CmM4502IXy4wZhAGWwCSWSAyYx"

LoginModal loginModalFromJson(String str) =>
    LoginModal.fromJson(json.decode(str));
String loginModalToJson(LoginModal data) => json.encode(data.toJson());

class LoginModal {
  LoginModal({
    this.user,
    this.token,
  });

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

/// id : 1
/// status : 0
/// name : "Admin"
/// email : "admin@gmail.com"
/// previlage : 1
/// email_verified_at : null
/// created_at : null
/// updated_at : "2024-04-19T12:41:36.000000Z"

User userFromJson(String str) => User.fromJson(json.decode(str));
String userToJson(User data) => json.encode(data.toJson());

class User {
  User({
    this.id,
    this.status,
    this.name,
    this.email,
    this.previlage,
    this.emailVerifiedAt,
    this.createdAt,
    this.updatedAt,
  });

  User.fromJson(dynamic json) {
    id = json['id'];
    status = json['status'];
    name = json['name'];
    email = json['email'];
    previlage = json['previlage'];
    emailVerifiedAt = json['email_verified_at'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }
  int? id;
  int? status;
  String? name;
  String? email;
  int? previlage;
  dynamic emailVerifiedAt;
  dynamic createdAt;
  String? updatedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['status'] = status;
    map['name'] = name;
    map['email'] = email;
    map['previlage'] = previlage;
    map['email_verified_at'] = emailVerifiedAt;
    map['created_at'] = createdAt;
    map['updated_at'] = updatedAt;
    return map;
  }
}
