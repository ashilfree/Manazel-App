import 'package:get/get.dart';
import 'package:manazel_alabrar/Api/Api.dart';

class AboutUs {


   int id;
   String name;
   String type;
   String setting;
   String setting2;
   String createdAt;
   String updatedAt;
   String image;

   getName(){
     return Get.locale.languageCode == "ar" ? setting : setting2;
   }

  AboutUs();

  AboutUs.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    if(json['name']!=null){
      name = Url.getLinkSettingFiles(json['name']);
      print(name);
    }
    type = json['type'];
    setting = json['setting'];
    setting2 = json['setting2'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['type'] = this.type;
    data['setting'] = this.setting;
    data['setting2'] = this.setting2;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['image'] = this.image;
    return data;
  }
}