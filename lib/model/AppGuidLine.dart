


import 'package:manazel_alabrar/Helper/MyTranslations.dart';

class AppGuidLine {
   int id;
   String title;
   String enTitle;
   String description;
   String enDescription;
   String image;
   String type;
   String createdAt;
   String updatedAt;

  AppGuidLine();

  AppGuidLine.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    enTitle = json['en_title'];
    description = json['description'];
    enDescription = json['en_description'];
    image = json['image'];
    type = json['type'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['en_title'] = this.enTitle;
    data['description'] = this.description;
    data['en_description'] = this.enDescription;
    data['image'] = this.image;
    data['type'] = this.type;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }

  String getTitle() {
    return isArabic ? title : enTitle;
  }
  String getDes() {
    return isArabic ? description : enDescription;
  }


}