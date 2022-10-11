


import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:manazel_alabrar/Helper/Screen.dart';
import 'package:manazel_alabrar/Login/RecordVoice/widget/AudioPlayerWidget.dart';
import 'package:manazel_alabrar/Login/RecordVoice/Controller/RecordVoiceController.dart';
import 'package:manazel_alabrar/Login/SignUp/SignUpController.dart';
import 'package:sizer/sizer.dart';




class DialogHearAya extends StatelessWidget {
  final RecordVoiceController controller;
  const DialogHearAya({Key key, this.controller}) : super(key: key);
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

                      SizedBox(height: 20,),

                      Text(Get.find<SignUpController>().ayaTest.value.name),

                      AudioPlayerWidget(file:Get.find<SignUpController>().ayaTest.value.setting2,onPlay:(w){

                      },myAudio: MyAudio(
                          name: 'Online',
                          audio: Audio.network(Get.find<SignUpController>().ayaTest.value.setting2),),
                      ),

                      ElevatedButton(
                        child: Text("dialog.ok".tr,textAlign: TextAlign.center,style: TextStyle(
                            fontSize: 13.sp,
                            color: Colors.white,
                            fontWeight: FontWeight.bold),),
                        onPressed: () async{
                          Get.back();
                        },
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
