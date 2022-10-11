

import 'package:get/get.dart';
import 'package:manazel_alabrar/Api/Api.dart';
import 'package:manazel_alabrar/Api/Url.dart';
import 'package:manazel_alabrar/model/Notification.dart';
import 'package:manazel_alabrar/model/Result.dart';

class NotificationsController extends GetxController{


  RxBool loading = true.obs;
  RxList<NotificationData> list = RxList<NotificationData>([]);


  getNotification()async{
    loading.value = true;
    try{
      dynamic json = await Api().get(Url.url+Url.get_notifications,queryParams: {"lang":Get.locale.languageCode},withAuthorization: true);

      ResultApi resultApi = ResultApi.fromJson(json);

      if(resultApi.state == 0){
        loading.value  = false;
        return;
      }

      for(dynamic json in json["success"]){
        list.add(NotificationData.fromJson(json));
      }

      loading.value  = false;
    } catch(err){
      print("err : " + err.toString());
      loading.value  = false;
    }
  }

  @override
  void onInit() {
    getNotification();
    super.onInit();
  }


}