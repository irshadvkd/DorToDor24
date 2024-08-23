import 'dart:convert';

/// governorate : [{"id":1,"name_eng":"Al-Ahmadi Governorate","name_ar":"محافظة الأحمدي"}]
/// city : [{"id":1,"name_eng":"Sabah Al-Ahmed B","name_ar":"صباح الأحمد ب","gov_id":1}]
/// block : [{"id":1,"name_eng":"Block 1","name_ar":"كتلة 1","gov_id":1,"city_id":1},{"id":2,"name_eng":"Block 2","name_ar":"كتلة 2","gov_id":1,"city_id":1},{"id":3,"name_eng":"A5","name_ar":"A5","gov_id":1,"city_id":1}]

LocationModal locationModalFromJson(String str) =>
    LocationModal.fromJson(json.decode(str));
String locationModalToJson(LocationModal data) => json.encode(data.toJson());

class LocationModal {
  LocationModal({
    this.governorate,
    this.city,
    this.block,
  });

  LocationModal.fromJson(dynamic json) {
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

/// id : 1
/// name_eng : "Block 1"
/// name_ar : "كتلة 1"
/// gov_id : 1
/// city_id : 1

Block blockFromJson(String str) => Block.fromJson(json.decode(str));
String blockToJson(Block data) => json.encode(data.toJson());

class Block {
  Block({
    this.id,
    this.nameEng,
    this.nameAr,
    this.govId,
    this.cityId,
  });

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

/// id : 1
/// name_eng : "Sabah Al-Ahmed B"
/// name_ar : "صباح الأحمد ب"
/// gov_id : 1

City cityFromJson(String str) => City.fromJson(json.decode(str));
String cityToJson(City data) => json.encode(data.toJson());

class City {
  City({
    this.id,
    this.nameEng,
    this.nameAr,
    this.govId,
  });

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

/// id : 1
/// name_eng : "Al-Ahmadi Governorate"
/// name_ar : "محافظة الأحمدي"

Governorate governorateFromJson(String str) =>
    Governorate.fromJson(json.decode(str));
String governorateToJson(Governorate data) => json.encode(data.toJson());

class Governorate {
  Governorate({
    this.id,
    this.nameEng,
    this.nameAr,
  });

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
