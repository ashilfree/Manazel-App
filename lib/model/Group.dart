import 'package:manazel_alabrar/Helper/MyTranslations.dart';

class Group {
  int id;
  String name;
  String enName;
  int adminId;
  int groupId;
  int levelId;
  int subLevelId;
  int weekId;
  int maxStudents;
  int studentCount;
  String banFrom;
  String banTo;
  String createdAt;
  String updatedAt;
  String status;


  bool get isBanned{
    print(status);
    return status == "banned";
  }


  Group(
      {this.id,
        this.name,
        this.enName,
        this.adminId,
        this.groupId,
        this.levelId,
        this.subLevelId,
        this.weekId,
        this.maxStudents,
        this.studentCount,
        this.banFrom,
        this.banTo,
        this.createdAt,
        this.updatedAt,
        this.status});

  Group.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    enName = json['en_name'];
    adminId = json['admin_id'];
    groupId = json['group_id'];
    levelId = json['level_id'];
    subLevelId = json['sub_level_id'];
    weekId = json['week_id'];
    maxStudents = json['max_students'];
    studentCount = json['student_count'];
    banFrom = json['ban_from'];
    banTo = json['ban_to'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['en_name'] = this.enName;
    data['admin_id'] = this.adminId;
    data['group_id'] = this.groupId;
    data['level_id'] = this.levelId;
    data['sub_level_id'] = this.subLevelId;
    data['week_id'] = this.weekId;
    data['max_students'] = this.maxStudents;
    data['student_count'] = this.studentCount;
    data['ban_from'] = this.banFrom;
    data['ban_to'] = this.banTo;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['status'] = this.status;
    return data;
  }

  String getName() {
    return isArabic ? name : enName;
  }
}