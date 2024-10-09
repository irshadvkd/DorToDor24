import 'dart:convert';
StoreLocationModal storeLocationModalFromJson(String str) => StoreLocationModal.fromJson(json.decode(str));
String storeLocationModalToJson(StoreLocationModal data) => json.encode(data.toJson());
class StoreLocationModal {
  StoreLocationModal({
      this.governorate, 
      this.city, 
      this.block,});

  StoreLocationModal.fromJson(dynamic json) {
    if (json['governorate'] != null) {
      governorate = [];
      json['governorate'].forEach((v) {
        governorate?.add(Governorate.fromJson(v));
      });
    }
    if (json['city'] != null) {
      city = [];
      json['city'].forEach((v) {
        city?.add(City.fromJson(v));
      });
    }
    if (json['block'] != null) {
      block = [];
      json['block'].forEach((v) {
        block?.add(Block.fromJson(v));
      });
    }
  }
  List<Governorate>? governorate;
  List<City>? city;
  List<Block>? block;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (governorate != null) {
      map['governorate'] = governorate?.map((v) => v.toJson()).toList();
    }
    if (city != null) {
      map['city'] = city?.map((v) => v.toJson()).toList();
    }
    if (block != null) {
      map['block'] = block?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

Block blockFromJson(String str) => Block.fromJson(json.decode(str));
String blockToJson(Block data) => json.encode(data.toJson());
class Block {
  Block({
      this.id, 
      this.nameEng, 
      this.nameAr, 
      this.govId, 
      this.cityId,});

  Block.fromJson(dynamic json) {
    id = json['id'];
    nameEng = json['name_eng'];
    nameAr = json['name_ar'];
    govId = json['gov_id'];
    cityId = json['city_id'];
  }
  int? id;
  String? nameEng;
  String? nameAr;
  int? govId;
  int? cityId;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name_eng'] = nameEng;
    map['name_ar'] = nameAr;
    map['gov_id'] = govId;
    map['city_id'] = cityId;
    return map;
  }

}

City cityFromJson(String str) => City.fromJson(json.decode(str));
String cityToJson(City data) => json.encode(data.toJson());
class City {
  City({
      this.id, 
      this.nameEng, 
      this.nameAr, 
      this.govId,});

  City.fromJson(dynamic json) {
    id = json['id'];
    nameEng = json['name_eng'];
    nameAr = json['name_ar'];
    govId = json['gov_id'];
  }
  int? id;
  String? nameEng;
  String? nameAr;
  int? govId;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name_eng'] = nameEng;
    map['name_ar'] = nameAr;
    map['gov_id'] = govId;
    return map;
  }

}

Governorate governorateFromJson(String str) => Governorate.fromJson(json.decode(str));
String governorateToJson(Governorate data) => json.encode(data.toJson());
class Governorate {
  Governorate({
      this.id, 
      this.nameEng, 
      this.nameAr,});

  Governorate.fromJson(dynamic json) {
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