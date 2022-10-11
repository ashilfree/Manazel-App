import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:manazel_alabrar/Tabs/MyAccount/Notification/NotificationsController.dart';


class NotificationsScreenTeacher extends GetView<NotificationsController> {
  static const String routeName = "NotificationsScreenTeacher";
  const NotificationsScreenTeacher({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("notifications.appBar".tr),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(15),
          child: Material(
            elevation: 10,
            child: Container(
              height: MediaQuery.of(context).size.height * 0.15,
              width: double.infinity,
              alignment: Alignment.center,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "What is Lorem Ipsum ?",
                    style: TextStyle(
                        color: Color(0xff8d7249),
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Icon(
                    Icons.error,
                    color: Color(0xff8d7249),
                    size: 30,
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

