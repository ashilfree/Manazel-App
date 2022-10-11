

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:manazel_alabrar/Api/Api.dart';
import 'package:manazel_alabrar/BottomBar/MainScreen.dart';
import 'package:manazel_alabrar/Firebase/FirebaseController.dart';
import 'package:manazel_alabrar/Helper/Messages.dart';
import 'package:manazel_alabrar/Helper/Storage.dart';
import 'package:manazel_alabrar/model/Result.dart';
import 'package:manazel_alabrar/model/Token.dart';
import 'package:manazel_alabrar/model/User.dart';
import 'package:provider/provider.dart';




class SignInController extends GetxController{


  TextEditingController name = TextEditingController();
  TextEditingController password = TextEditingController();
  RxBool loading = false.obs;
  RxBool rememberMe = false.obs;

  var from = GlobalKey<FormState>();



  signIn()async{

    if(!from.currentState.validate()){
       return;
    }

    loading.value = true;

    try{
      dynamic json = await Api().post(Url.url+Url.login,data: {
        "username":name.text,
        "password":password.text,
      },queryParams:{"lang":Get.locale.languageCode},withAuthorization: false);


      ResultApi result = ResultApi.fromJson(json);

      if(result.state == 0){
        print("err : " + result.error);
        error(result.error);
        loading.value  = false;
        return;
      }


      getDataUser(Token.fromJson(json));
      refreshToken(Token.fromJson(json));

    } catch(err){
      print("err : " + err.toString());
      error(err.toString());
      loading.value  = false;
    }
  }


  void refreshToken(Token token)async{
    String firebaseToken = await FirebaseMessaging.instance.getToken();
    dynamic data = await Api().post(Url.url+Url.refreshToken,withAuthorization: true,data: {"push_token":firebaseToken},token: token.accessToken);
    print("reslt refresh Toke : " + data.toString());
  }


  void getDataUser(Token token) async{

    Get.context.read<User>().token = token;
    loading.value = true;

    try{
      dynamic json = await Api().get(Url.url+Url.user,token: token.accessToken);

      ResultApi result = ResultApi.fromJson(json);

      if(result.state == 0){
        print("err : " + result.error);
        error(result.error);
        loading.value  = false;
        return;
      }

      Get.context.read<User>().fromJson(json,notify: false,isNewUser: true);
      if(rememberMe.value){
        Storage.saveUser(Get.context.read<User>().toJson());
      }

      if(Get.context.read<User>().isTeacher){
        FirebaseController.subScribeTeachers();
      }else{
        FirebaseController.subScribeStudent();
      }

      Get.reset();
      Get.offAllNamed(MainScreen.routeName);

    } catch(err){
      print("err : " + err.toString());
      loading.value  = false;
    }
  }


}

