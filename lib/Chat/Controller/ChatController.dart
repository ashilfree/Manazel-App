
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:manazel_alabrar/Api/Api.dart';
import 'package:manazel_alabrar/Firebase/FirebaseController.dart';
import 'package:manazel_alabrar/model/MessageData.dart';
import 'package:manazel_alabrar/model/MessageType.dart';
import 'package:manazel_alabrar/model/Result.dart';
import 'package:manazel_alabrar/model/Student.dart';
import 'package:manazel_alabrar/model/User.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:provider/provider.dart';



class ChatController extends GetxController {


  static ChatController controller;
  TextEditingController messageController = TextEditingController();
  RxBool enablePullUp = true.obs;
  RxBool loadingList = false.obs;
  RxBool initDone = false.obs;
  RxBool showMic = true.obs;
  int limit = 30;
  Student student = Get.arguments["student"];
  RxList<MessageData> list = RxList<MessageData>([]);
  RefreshController refreshController = RefreshController(initialRefresh: false);
  int countLoaded = 0;
  var globalPositionMic = GlobalKey();


  Offset positionMic(){
    RenderBox box = globalPositionMic.currentContext.findRenderObject();
    return box.localToGlobal(Offset.zero);
  }


  sendMessage() async{
    if (messageController.text.isNotEmpty) {
      String message = messageController.text;
      FirebaseMessaging.instance.sendToTopic(student.id.toString(),messageController.text,senderName: Get.context.read<User>().username,senderId: student.id.toString(),messageType: MessageType.text);
      messageController.text = "";
      showMic.value = true;
     dynamic data = await Api().post(Url.url + Url.sendMessage,
          data: {"message": message},
          queryParams: {
            "lang": Get.locale.languageCode,
            "si": student.id.toString(),
          },
          withAuthorization: true);
    }
  }


  void onRefresh() {

  }


  void onLoadingRefresh() async{
    print("load more data");

    if(countLoaded == 0){
      return;
    }

    try{
      String url = Url.url+Url.get_messages+"/$countLoaded/"+limit.toString();
      print(url + "student id : " + student.id.toString());
      dynamic data = await Api().get(url, queryParams: {"lang":Get.locale.languageCode,"si":student.id.toString()}, withAuthorization: true);
      ResultApi resultApi = ResultApi.fromJson(data);



      if(resultApi.state == 1){

        if(data["messages"].isEmpty){
          enablePullUp.value = false;
        }

        for(dynamic json in data["messages"]){
          list.add(MessageData.fromJson(json));
          countLoaded++;
        }

      }

      refreshController.loadComplete();
      refreshController.refreshToIdle();

    } catch(err){
      print("err : " + err.toString());
    }
  }


  getMessages() async{
    loadingList.value = true;
    try{
      String url = Url.url+Url.get_messages+"/0/"+limit.toString();
      print(url + "student id : " + student.id.toString());
      dynamic data = await Api().get(url, queryParams: {"lang":Get.locale.languageCode,"si":student.id.toString()}, withAuthorization: true);
      ResultApi resultApi = ResultApi.fromJson(data);

      if(resultApi.state == 1){

        if(data["messages"].isEmpty){
          enablePullUp.value = false;
        }

        for(dynamic json in data["messages"]){
          list.add(MessageData.fromJson(json));
          countLoaded++;
        }
      }
      loadingList.value  = false;
    } catch(err){
      print("err : " + err.toString());
      loadingList.value  = false;
    }
  }




  @override
  void onReady() async{
    getMessages();
    print("subscribe topic ====   "+student.id.toString());
    FirebaseMessaging.instance.subscribeToTopic(student.id.toString());
    FirebaseController.desblenotification();
    ChatController.controller = this;
    await Future.delayed(Duration(milliseconds: 500));
    initDone.value = true;
    super.onReady();
  }



  void showRecordDialog() {

  }


  @override
  void onClose() {
    FirebaseMessaging.instance.unsubscribeFromTopic(student.id.toString());
    ChatController.controller = null;
    FirebaseController.enablenotification();
    super.onClose();
  }


  void newMessage(RemoteMessage message,bool isText,bool isVoice,senderId) {
    if(senderId == student.id.toString()){
       getLastMessage();
    }
  }


  void getLastMessage() async{
    try{
      dynamic data = await Api().get(Url.url+Url.get_messages+"/0/"+"1", queryParams: {"lang":Get.locale.languageCode,"si":student.id.toString()}, withAuthorization: true);
      ResultApi resultApi = ResultApi.fromJson(data);
      if(resultApi.state == 1){
        for(dynamic json in data["messages"]){
          list.insert(0,MessageData.fromJson(json));
          print(json.toString());
        }
      }
    } catch(err){
      print("err : " + err.toString());
    }
  }



  void addStatus(String status) async{
    var data = {
      "status":status,
      "si":student.id.toString(),
    };
    dynamic json = await Api().post(Url.url+Url.user_read,queryParams: {"lang":Get.locale.languageCode},data:data ,withAuthorization: true);
  }



}
