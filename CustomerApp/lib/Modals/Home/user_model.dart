class User {
  int? id;
  int? status;
  int? activeStatus;
  String name;
  String email;
  int? privilege;
  String phone;
  String? govId;
  String? cityId;
  String? blockId;
  String? disableProduct;
  String? emailVerifiedAt;
  String createdAt;
  String updatedAt;

  User({
    this.id,
    this.status,
    this.activeStatus,
    required this.name,
    required this.email,
    this.privilege,
    required this.phone,
    this.govId,
    this.cityId,
    this.blockId,
    this.disableProduct,
    this.emailVerifiedAt,
    required this.createdAt,
    required this.updatedAt,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      status: json['status'],
      activeStatus: json['active_status'],
      name: json['name'],
      email: json['email'],
      privilege: json['previlage'],
      phone: json['phone'],
      govId: json['gov_id'],
      cityId: json['city_id'],
      blockId: json['block_id'],
      disableProduct: json['disable_product'],
      emailVerifiedAt: json['email_verified_at'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'status': status,
      'active_status': activeStatus,
      'name': name,
      'email': email,
      'privilege': privilege,
      'phone': phone,
      'gov_id': govId,
      'city_id': cityId,
      'block_id': blockId,
      'disable_product': disableProduct,
      'email_verified_at': emailVerifiedAt,
      'created_at': createdAt,
      'updated_at': updatedAt,
    };
  }
}
