


import 'package:get/get.dart';

class MyLevel {
  int state;
  Level myLevel;
  SubLevel subLevel;


  bool subLevelIsNull = false;

  MyLevel({this.state, this.myLevel, this.subLevel});

  MyLevel.fromJson(Map<String, dynamic> json) {
    state = json['state'];
    myLevel = json['success'] != null ? new Level.fromJson(json['success']) : null;
    subLevelIsNull = json['sub_level'] != null;
    subLevel = json['sub_level'] != null ? new SubLevel.fromJson(json['sub_level']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['state'] = this.state;
    if (this.myLevel != null) {
      data['success'] = this.myLevel.toJson();
    }
    if (this.subLevel != null) {
      data['sub_level'] = this.subLevel.toJson();
    }
    return data;
  }


}

class Level {
  int id;
  String name;
  String enName;
  String level;
  String enLevel;
  String createdAt;
  String updatedAt;
  getName() {
    return Get.locale.languageCode == "ar" ? name : enName;
  }
  Level(
      {this.id,
        this.name,
        this.enName,
        this.level,
        this.enLevel,
        this.createdAt,
        this.updatedAt});

  Level.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    enName = json['en_name'];
    level = json['level'];
    enLevel = json['en_level'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['en_name'] = this.enName;
    data['level'] = this.level;
    data['en_level'] = this.enLevel;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

class SubLevel {
  int id;
  String name;
  String enName;
  int levelId;


  getName() {
    return Get.locale.languageCode == "ar" ? name : enName;
  }

  SubLevel(
      {this.id,
        this.name,
        this.enName,
        this.levelId,});

  SubLevel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    enName = json['en_name'];
    levelId = json['level_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['en_name'] = this.enName;
    data['level_id'] = this.levelId;
    return data;
  }
}