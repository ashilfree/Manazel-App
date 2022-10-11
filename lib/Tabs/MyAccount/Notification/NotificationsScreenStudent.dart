import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:manazel_alabrar/Helper/EmptyList.dart';
import 'package:manazel_alabrar/Helper/Loading.dart';
import 'package:manazel_alabrar/Tabs/MyAccount/Notification/NotificationsController.dart';
import 'package:manazel_alabrar/model/Notification.dart';

class NotificationsScreenStudent extends GetView<NotificationsController> {
  static const String routeName = "NotificationsScreenStudent";
  const NotificationsScreenStudent({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("notifications.appBar".tr),
      ),
      body: Padding(
          padding: EdgeInsets.all(10),
          child: Obx((){


            if(controller.loading.value){
              return LoadingPage();
            }

            if(controller.list.isEmpty){
              return EmptyList(
                text: "notifications.empty".tr,
              );
            }

            return ListView.builder(
                itemCount: controller.list.length,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  NotificationData notification = controller.list[index];

                  return NotificationCard(
                    notification: notification,
                  );

                });
          })),
    );
  }
}

class NotificationCard extends StatelessWidget {
  final NotificationData notification;
  const NotificationCard({Key key, this.notification}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Material(
          elevation: 5,
          child: Container(
            padding: EdgeInsets.all(10),
            height: MediaQuery.of(context).size.height * 0.15,
            width: double.infinity,
            alignment: Alignment.center,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  notification.getName(),
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 18),
                ),
              ],
            ),
          )),
    );
  }
}
