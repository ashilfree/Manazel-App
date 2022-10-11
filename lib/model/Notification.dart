import 'package:get/get.dart';

class NotificationData {
  int id;
  String title;
  String notification;
  int userId;
  String type;
  String createdAt;
  String updatedAt;

  NotificationData(
      {this.id,
        this.title,
        this.notification,
        this.userId,
        this.type,
        this.createdAt,
        this.updatedAt});

  NotificationData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    notification = json['notification'];
    userId = json['user_id'];
    type = json['type'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['notification'] = this.notification;
    data['user_id'] = this.userId;
    data['type'] = this.type;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }

  String getName() {
    return Get.locale.languageCode == "ar" ? title : notification;
  }
}