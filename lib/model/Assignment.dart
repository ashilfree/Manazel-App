

import 'package:get/get.dart';

class Assignment {
  int id;
  String weekName;
  String weekEnName;
  int weekNumber;
  String homeworkFilePath;
  String homeworkFileUrl;
  String homeworkFileName;
  String tajweedLink;
  String tafsirLink;
  int subLevelId;
  String createdAt;
  String updatedAt;

  Assignment(
      {this.id,
        this.weekName,
        this.weekEnName,
        this.weekNumber,
        this.homeworkFilePath,
        this.homeworkFileUrl,
        this.homeworkFileName,
        this.tajweedLink,
        this.tafsirLink,
        this.subLevelId,
        this.createdAt,
        this.updatedAt});

  Assignment.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    weekName = json['week_name'];
    weekEnName = json['week_en_name'];
    weekNumber = json['week_number'];
    homeworkFilePath = json['homework_file_path'];
    homeworkFileUrl = json['homework_file_url'];
    homeworkFileName = json['homework_file_name'];
    tajweedLink = json['tajweed_link'];
    tafsirLink = json['tafsir_link'];
    subLevelId = json['sub_level_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['week_name'] = this.weekName;
    data['week_en_name'] = this.weekEnName;
    data['week_number'] = this.weekNumber;
    data['homework_file_path'] = this.homeworkFilePath;
    data['homework_file_url'] = this.homeworkFileUrl;
    data['homework_file_name'] = this.homeworkFileName;
    data['tajweed_link'] = this.tajweedLink;
    data['tafsir_link'] = this.tafsirLink;
    data['sub_level_id'] = this.subLevelId;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }



  String getNameWeek() {
    return Get.locale.languageCode == "ar" ? weekName : weekEnName;
  }

}