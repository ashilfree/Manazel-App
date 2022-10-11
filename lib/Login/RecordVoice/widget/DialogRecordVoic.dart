

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:manazel_alabrar/Helper/Screen.dart';
import 'package:manazel_alabrar/Login/RecordVoice/Controller/RecordVoiceController.dart';
import 'package:sizer/sizer.dart';


class DialogRecordVoice extends StatelessWidget {
  final RecordVoiceController controller;
  const DialogRecordVoice({Key key, this.controller}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: isPortal ? Get.height * 50 / 100 : Get.width * 100 / 100,
        child:Stack(
          alignment: Alignment.center,
          children: [
            Container(
              constraints: BoxConstraints(
                minHeight: Get.height * 0.33,
                maxHeight: Get.height * 0.33,
                maxWidth: Get.width * 0.8,
                minWidth: Get.width * 0.8,
              ),
              padding: EdgeInsets.all(10),
              color: Colors.white,
              child: Card(
                elevation: 0,
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [

                      Expanded(flex: 3,child: Obx((){
                        return FloatingActionButton(
                          backgroundColor: Get.theme.primaryColor,
                          onPressed: (){
                            if(controller.isRecording.value){
                               controller.stop();
                              return;
                            }
                            controller.startRecord();
                          },
                          child: Icon(controller.isRecording.value ? Icons.stop : Icons.mic,size: 30.sp,),
                        );
                      })),

                      Expanded(flex: 1,child: Obx((){
                        return Text(controller.time.value,style: TextStyle(
                            fontSize: 13.sp,
                            fontWeight: FontWeight.bold
                        ),);
                      })),


                      Expanded(
                        flex: 1,
                        child: Row(
                          children: [
                            Expanded(
                              child: ElevatedButton(
                                child: Text("dialog.cancel".tr,textAlign: TextAlign.center,style: TextStyle(
                                    fontSize: 13.sp,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),),
                                onPressed: () async{
                                  if(controller.isRecording.value){
                                     controller.stop();
                                  }
                                  Get.back();
                                },
                              ),
                            ),
                            SizedBox(width: 20,),
                            Expanded(
                              child:ElevatedButton(
                                child: Text("dialog.ok".tr,textAlign: TextAlign.center,style: TextStyle(
                                    fontSize: 13.sp,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),),
                                onPressed: () {
                                  if(controller.isRecording.value){
                                     controller.stop();
                                  }
                                  Get.back();
                                },
                              ),
                            )
                          ],
                        ),
                      )

                    ]),
              ),
            ),
            Positioned(
              top: 10,
              child: CircleAvatar(
                radius: 50,
                backgroundColor: Colors.white,
                child: Image.asset(
                  'assets/images/c_logo.png',
                  height: 70,
                  width: 70,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
