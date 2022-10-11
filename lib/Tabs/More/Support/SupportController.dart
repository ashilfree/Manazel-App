


import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:manazel_alabrar/Api/Api.dart';
import 'package:manazel_alabrar/Api/Url.dart';
import 'package:manazel_alabrar/Tabs/More/Support/SupportScreen.dart';
import 'package:manazel_alabrar/model/Result.dart';


class SupportController extends GetxController{


  TextEditingController name = TextEditingController();
  TextEditingController phone_number = TextEditingController();
  TextEditingController message = TextEditingController();
  RxBool loading = false.obs;

  var form = GlobalKey<FormState>();

  send()async{

    loading.value = true;

    try{
      dynamic json = await Api().post(Url.url+Url.support_message,data: {
        "name":name.text,
        "phone_number":phone_number.text,
        "message":message.text,
      },queryParams: {"lang":Get.locale.languageCode},withAuthorization: false);

      ResultApi result = ResultApi.fromJson(json);

      if(result.state == 1){
        if(Get.currentRoute == SupportScreen.routeName){
          Get.back(result: true);
        }
        print("err : " + result.success);
      }else{
        print("err : " + result.error);
      }

      loading.value  = false;

    } catch(err){
      print("err : " + err.toString());
      loading.value  = false;
    }

  }


}