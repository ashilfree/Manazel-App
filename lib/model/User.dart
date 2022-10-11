
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:manazel_alabrar/model/Token.dart';
import 'package:manazel_alabrar/model/UserType.dart';
import 'package:manazel_alabrar/Api/Url.dart';



class User with ChangeNotifier{


   bool isNull = true;
   int id;
   String username;
   String email;
   String phone;
   String birthday;
   int quranParts;
   String spareTime;
   String workHours;
   String type;
   String image;
   String availableTimes;
   dynamic levelId;
   dynamic subLevelId;
   int countryId;
   dynamic emailVerifiedAt;
   dynamic lang;
   int mogazh;
   int masteryCertificates;
   dynamic pushToken;
   String createdAt;
   String updatedAt;
   Token token;
   UserType userType;


   DateTime getUserDate(){
     if(birthday.contains(r"\")){
       if(birthday.split(r"\")[0].length == 2){
         return DateTime(int.parse(birthday.split(r"\").last),int.parse(birthday.split(r"\")[1]),int.parse(birthday.split(r"\").first));
       }
     }
     return DateTime(int.parse(birthday.substring(0,4)),int.parse(birthday.substring(5,7)),int.parse(birthday.substring(8,10)));
   }

   User(
       {this.id,
         this.username,
         this.email,
         this.phone,
         this.birthday,
         this.quranParts,
         this.spareTime,
         this.workHours,
         this.type,
         this.image,
         this.levelId,
         this.subLevelId,
         this.countryId,
         this.emailVerifiedAt,
         this.lang,
         this.mogazh,
         this.masteryCertificates,
         this.pushToken,
         this.createdAt,
         this.updatedAt});



  User.fromJson(Map<String, dynamic> json,{notify = false}) {
    fromJson(json,notify: notify);
  }

  fromJson(json,{notify = false,bool isNewUser = false}){

    print("USER DATA :  " + json.toString());

    isNull = json == null;

    if(isNull){
      notifyListeners();
      return;
    }

    id = json['id'];
    username = json['username'];
    email = json['email'];
    phone = json['phone'];
    birthday = json['birthday'];
    quranParts = json['quran_parts'];
    spareTime = json['spare_time'];
    workHours = json['workـhours'];
    type = json['type'];

    availableTimes = json['spare_time'];

    if(type == UserType.teacher.toString().split(".")[1]){
      userType = UserType.teacher;
    }

    if(type == UserType.student.toString().split(".")[1]){
      userType = UserType.student;
    }


    print(UserType.student.toString().split(".")[1]);


    if(isNewUser){
      image = json['image'];
    }

    if(image!=null){
      image = Url.getLink(json['image']);
      print(image);
    }

    levelId = json['level_id'];
    subLevelId = json['sub_level_id'];
    countryId = json['country_id'];
    emailVerifiedAt = json['email_verified_at'];
    lang = json['lang'];
    mogazh = json['mogazh'];
    masteryCertificates = json['mastery_certificates'];
    pushToken = json['push_token'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];

    if(json['token']!=null){
      token = Token.fromJson(json['token']);
    }

    if(notify){
       notifyListeners();
    }

    print("new user name : " + username);
  }

  bool get isTeacher{
   return userType == UserType.teacher;
  }

   Map<String, dynamic> toJson() {
     final Map<String, dynamic> data = new Map<String, dynamic>();
     data['id'] = this.id;
     data['username'] = this.username;
     data['email'] = this.email;
     data['phone'] = this.phone;
     data['birthday'] = this.birthday;
     data['quran_parts'] = this.quranParts;
     data['spare_time'] = this.spareTime;
     data['workـhours'] = this.workHours;
     data['type'] = this.type;
     data['image'] = this.image;
     data['level_id'] = this.levelId;
     data['sub_level_id'] = this.subLevelId;
     data['country_id'] = this.countryId;
     data['email_verified_at'] = this.emailVerifiedAt;
     data['lang'] = this.lang;
     data['mogazh'] = this.mogazh;
     data['mastery_certificates'] = this.masteryCertificates;
     data['push_token'] = this.pushToken;
     data['created_at'] = this.createdAt;
     data['updated_at'] = this.updatedAt;
     data['availableTimes'] = this.availableTimes;
     data['token'] = this.token.toJson();
     return data;
   }

}