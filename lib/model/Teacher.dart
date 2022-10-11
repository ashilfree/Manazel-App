

import 'package:manazel_alabrar/Helper/MyTranslations.dart';

class Teacher {
  String teacherName;
  int group;
  String groupName;
  String enGroupName;
  String groupStatus;

  Teacher(
      {this.teacherName,
        this.group,
        this.groupName,
        this.enGroupName,
        this.groupStatus});

  Teacher.fromJson(Map<String, dynamic> json) {
    teacherName = json['teacher_name'];
    group = json['group'];
    groupName = json['group_name'];
    enGroupName = json['en_group_name'];
    groupStatus = json['group_status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['teacher_name'] = this.teacherName;
    data['group'] = this.group;
    data['group_name'] = this.groupName;
    data['en_group_name'] = this.enGroupName;
    data['group_status'] = this.groupStatus;
    return data;
  }

  String getName() {
    return isArabic ? groupName : enGroupName;
  }
}