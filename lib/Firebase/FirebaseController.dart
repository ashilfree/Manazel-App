


import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:manazel_alabrar/Chat/Controller/ChatController.dart';
import 'package:manazel_alabrar/Firebase/NotificationController.dart';
import 'package:manazel_alabrar/Helper/Storage.dart';
import 'package:manazel_alabrar/model/MessageType.dart';


extension Fire on FirebaseMessaging{

  sendToTopic(String topic,String message,{@required String senderId ,@required  String messageType,@required String senderName})async{
    final String serverToken = 'AAAAjwMQt5w:APA91bG54lENX0QU3gyRaD0_DceYuJOMLy1BhKiQeFK_tmk6wthzh_CxjLrzDZfYYv5Ep_-gRmfihqbULTgc5OGb4MHRFIoWeBoFZYaMjFvBngIcJpvYhm4v_vfaQoQRtowwl6sKjmqW';

    var data = await Dio().post('https://fcm.googleapis.com/fcm/send',data:jsonEncode(
      <String, dynamic>{
        'priority': 'high',
        "data": {
          "title": senderName,
          "text": message,
          // "badge":10,
          'senderId': senderId,
          'messageType': messageType,
          'topic': topic,
        },
        "android": {
          "priority": "high"
        },
        "notification":{
          "title": senderName,
          "body":message,
          // "sound": "default",
          'senderId': senderId,
          'messageType': messageType,
          'topic': topic,
        },
        "content_available":true,
        "apns-priority": "5",
        "apns": {
          "payload": {
            "aps": {
              "contentAvailable": true
            }
          },
          "headers": {
            "apns-push-type": "background",
            "apns-priority": "5",
            "apns-topic": "deltasoft.com.arabawe-client"
          }
        },
        'to': "/topics/$topic",
      },
    ),options: Options(
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Authorization': 'key=$serverToken',
      },
    ));
  }

  // return RemoteMessage(
  // senderId: map['senderId'],
  // category: map['category'],
  // collapseKey: map['collapseKey'],
  // contentAvailable: map['contentAvailable'] ?? false,
  // data: map['data'] == null
  // ? <String, dynamic>{}
  //     : Map<String, dynamic>.from(map['data']),
  // from: map['from'],
  // // Note: using toString on messageId as it can be an int or string when being sent from native.
  // messageId: map['messageId']?.toString(),
  // messageType: map['messageType'],
  // mutableContent: map['mutableContent'] ?? false,
  // notification: map['notification'] == null
  // ? null
  //     : RemoteNotification.fromMap(
  // Map<String, dynamic>.from(map['notification'])),
  // // Note: using toString on sentTime as it can be an int or string when being sent from native.
  // sentTime: map['sentTime'] == null
  // ? null
  //     : DateTime.fromMillisecondsSinceEpoch(
  // int.parse(map['sentTime'].toString())),
  // threadId: map['threadId'],
  // ttl: map['ttl'],
  // );
}


class FirebaseController{



  static init()async{

    FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
        alert: true,
        sound: true,
        badge: true
    );

    // on App Open by click notification
    FirebaseMessaging.instance.getInitialMessage().then((RemoteMessage message) {
      if (message != null) {
        print("getInitialMessage : " + message.messageId.toString());
      }
    });

    // Listener Messages
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {

      RemoteNotification notification = message.notification;
      AndroidNotification android = message.notification?.android;

      if(notification == null){
        return;
      }

      print("new message ------------------------- " + message.data["messageType"].toString());

      if(ChatController.controller!=null){
        ChatController.controller.newMessage(
            message,
            message.data["messageType"].toString() == MessageType.text,
            message.data["messageType"].toString() == MessageType.audio,
            message.data["senderId"].toString(),
        );
      }



    });

    // on App Open
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print('A new onMessageOpenedApp event was published!');
    });




     // testSendNotificationForMe();
  }


  static unSubscribeAll() async {
    FirebaseMessaging.instance.unsubscribeFromTopic("all");
    FirebaseMessaging.instance.unsubscribeFromTopic("student");
    FirebaseMessaging.instance.unsubscribeFromTopic("students");
    FirebaseMessaging.instance.unsubscribeFromTopic("teacher");
    FirebaseMessaging.instance.unsubscribeFromTopic("teachers");
    FirebaseMessaging.instance.deleteToken();
    FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
      alert: false,
      sound: false,
      badge: false
    );
  }

  static subScribeStudent(){
    FirebaseMessaging.instance.unsubscribeFromTopic("all");
    FirebaseMessaging.instance.unsubscribeFromTopic("student");
    FirebaseMessaging.instance.unsubscribeFromTopic("students");
  }

  static subScribeTeachers()async{
    FirebaseMessaging.instance.unsubscribeFromTopic("all");
    FirebaseMessaging.instance.unsubscribeFromTopic("teacher");
    FirebaseMessaging.instance.unsubscribeFromTopic("teachers");
  }


  static desblenotification()async{
    FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
        alert: false,
        sound: false,
        badge: false
    );
  }

  static enablenotification()async{
    FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
        alert: true,
        sound: true,
        badge: true
    );
  }


  static Future<void> backGroundMessage(RemoteMessage message) async {
    if(message.data.containsKey("topic")){
      if(!await Storage.userExist()){
        FirebaseMessaging.instance.unsubscribeFromTopic(message.data["topic"].toString());
      }
    }
    print('Handling a background message ${message.messageId}');
  }

  static testSendNotificationForMe()async{
    final String serverToken = 'AAAAjwMQt5w:APA91bG54lENX0QU3gyRaD0_DceYuJOMLy1BhKiQeFK_tmk6wthzh_CxjLrzDZfYYv5Ep_-gRmfihqbULTgc5OGb4MHRFIoWeBoFZYaMjFvBngIcJpvYhm4v_vfaQoQRtowwl6sKjmqW';
    String token = await FirebaseMessaging.instance.getToken();
    print("firebase Token :  " + token.toString());
    await Dio().post('https://fcm.googleapis.com/fcm/send',data:jsonEncode(
      <String, dynamic>{
        'priority': 'high',
        'data': <String, dynamic>{
          'click_action': 'FLUTTER_NOTIFICATION_CLICK',
          'title': 'test notification',
          'body': 'test is working',
          'type':"test",
          'status': 'done'
        },
        'to': token,
      },
    ),options: Options(
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Authorization': 'key=$serverToken',
      },
    ));
  }


}