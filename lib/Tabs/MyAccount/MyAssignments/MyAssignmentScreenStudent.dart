import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:manazel_alabrar/Helper/EmptyList.dart';
import 'package:manazel_alabrar/Helper/Loading.dart';
import 'package:manazel_alabrar/Tabs/MyAccount/MyAssignments/MyAssignmentController.dart';
import 'package:manazel_alabrar/Tabs/MyAccount/MyAssignments/MyAssignmentWebView.dart';
import 'package:manazel_alabrar/Tabs/MyAccount/MyAssignments/PdfScreen.dart';


class MyAssignmentScreenStudent extends GetView<MyAssignmentController> {
  static const String routeName = "MyAssignmentScreenStudent";
  const MyAssignmentScreenStudent({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("myAssignment.appBar".tr),
      ),
      body: Obx((){

        if(controller.loading.value){
          return LoadingPage();
        }

        // if(controller.resultApi != null){
        //   return EmptyList(
        //     icon: Icons.bookmark_border,
        //     text: controller.resultApi.message,
        //   );
        // }

        if(controller.assignment.value == null){
          return EmptyList(
            icon: Icons.block,
            text: "myAssignment.error".tr,
          );
        }


        return SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(20),
              child: Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      controller.assignment.value.getNameWeek(),
                      style: TextStyle(fontSize: 28, fontWeight: FontWeight.w600),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Material(
                      elevation: 5,
                      child: Container(
                        alignment: Alignment.center,
                        height: 130,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "myAssignment.part1".tr,
                              style: TextStyle(
                                  fontSize: 25, fontWeight: FontWeight.w400),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                OutlinedButton(
                                    onPressed: () {
                                      Get.toNamed(PdfScreenApp.routeName,arguments: controller.assignment.value.homeworkFileUrl);
                                    },
                                    style: OutlinedButton.styleFrom(
                                        backgroundColor: Color(0xff8d7249)),
                                    child: Row(
                                      children: [
                                        Icon(Icons.insert_drive_file,
                                            color: Colors.white),
                                        Text(
                                          "myAssignment.view".tr,
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 17,
                                              fontWeight: FontWeight.bold),
                                        )
                                      ],
                                    )),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Material(
                      elevation: 5,
                      child: Container(
                        alignment: Alignment.center,
                        height: 130,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "myAssignment.tajweed".tr,
                              style: TextStyle(
                                  fontSize: 25, fontWeight: FontWeight.w400),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                OutlinedButton(
                                    onPressed: () {
                                      Get.toNamed(MyAssignmentWebView.routeName,arguments: controller.assignment.value.tajweedLink);
                                    },
                                    style: OutlinedButton.styleFrom(
                                        backgroundColor: Color(0xff8d7249)),
                                    child: Row(
                                      children: [
                                        Icon(Icons.insert_drive_file,
                                            color: Colors.white),
                                        Text(
                                          "myAssignment.view".tr,
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 17,
                                              fontWeight: FontWeight.bold),
                                        )
                                      ],
                                    )),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Material(
                      elevation: 5,
                      child: Container(
                        alignment: Alignment.center,
                        height: 130,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "myAssignment.tafsir".tr,
                              style: TextStyle(
                                  fontSize: 25, fontWeight: FontWeight.w400),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                OutlinedButton(
                                    onPressed: () {
                                      Get.toNamed(MyAssignmentWebView.routeName,arguments: controller.assignment.value.tafsirLink);
                                    },
                                    style: OutlinedButton.styleFrom(
                                        backgroundColor: Color(0xff8d7249)),
                                    child: Row(
                                      children: [
                                        Icon(Icons.insert_drive_file,
                                            color: Colors.white),
                                        Text(
                                          "myAssignment.view".tr,
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 17,
                                              fontWeight: FontWeight.bold),
                                        )
                                      ],
                                    )),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ));
      }),
    );
  }
}


