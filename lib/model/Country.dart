import 'package:get/get.dart';

class Country {

  int id;
  String name;
  String enName;
  String countryCode;
  String phoneCode;
  String createdAt;
  String updatedAt;
  String image;

  Country(
      {this.id,
        this.name,
        this.enName,
        this.countryCode,
        this.phoneCode,});

  Country.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    enName = json['en_name'];
    countryCode = json['country_code'];
    phoneCode = json['phone_code'];

    image = "assets/flags/${countryCode.toLowerCase()}.png";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['en_name'] = this.enName;
    data['country_code'] = this.countryCode;
    data['phone_code'] = this.phoneCode;
    return data;
  }

  String getName() {
    if(Get.locale.languageCode == "ar"){
       return name;
    }
    return enName;
  }
}