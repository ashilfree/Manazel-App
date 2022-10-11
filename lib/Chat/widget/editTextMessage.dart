
import 'dart:io';

import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter_audio_recorder/flutter_audio_recorder.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:manazel_alabrar/Chat/Controller/ChatController.dart';
import 'package:manazel_alabrar/Chat/Controller/ChatRecordVoice.dart';
import 'package:manazel_alabrar/Login/RecordVoice/widget/AudioPlayerWidget.dart';
import 'package:sizer/sizer.dart';



class EditTextMessage extends GetView<ChatRecordVoice> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      overflow: Overflow.visible,
      children: [
        Container(
          padding: const EdgeInsets.only(bottom: 10,top: 5 ,left: 15,right: 15),
          decoration: BoxDecoration(
            color: Color(0xFFE1E6EF),
          ),
          child: Column(
            children: <Widget>[

              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[

                  Expanded(
                    child: Obx((){

                      if(controller.isReadyToSendRecord.value){
                        return Container(height: 55,child: AudioPlayerWidget(file:controller.file.path,onPlay:(w){
                        },myAudio: MyAudio(
                          name: 'Online',
                          audio: Audio.file(controller.file.path),),
                        ),margin: EdgeInsets.only(right: 10),);
                      }


                      return Container(
                        margin: EdgeInsets.only(right: 10),
                        child:TextField(
                          textAlign: TextAlign.center,
                          controller: Get.find<ChatController>().messageController,
                          style: TextStyle(fontSize: 13.sp,height: 1.4),
                          autofocus: false,
                          cursorColor: Get.theme.primaryColor,
                          maxLines: 5,
                          minLines: 1,
                          onChanged: (text){
                            if(text.isNotEmpty){
                              Get.find<ChatController>().showMic.value = false;
                            }else{
                              Get.find<ChatController>().showMic.value = true;
                            }
                          },
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 10.0),
                            hintText: "chat.typeMessage".tr,
                            filled: true,
                            fillColor: Color(0xFFF8F8FC),
                            border: OutlineInputBorder(
                                borderRadius: new BorderRadius.circular(20),
                                borderSide: BorderSide.none
                            ),
                          ),
                        ),
                      );


                    }),
                  ),

                  SizedBox(width: 5,),

                  Obx((){
                    return controller.isReadyToSendRecord.value ? Row(
                      children: [

                        Container(
                          color: Colors.transparent,
                          width: 30.sp,
                          height: 30.sp,
                          child: FloatingActionButton(onPressed: (){
                            controller.delete();
                          },child: Icon(Icons.delete,color: Colors.red,),),
                        ),
                        SizedBox(width: 10,),
                        Container(
                          color: Colors.transparent,
                          width: 30.sp,
                          height: 30.sp,
                          child: FloatingActionButton(onPressed: (){
                            controller.sendRecord();
                          },child: Icon(Icons.send,),),
                        )

                      ],
                    ) : Container(width: 30,);
                  })

                ],
              ),
            ],
          ),
        ),




        Obx((){
          if(controller.isReadyToSendRecord.value){
            return Container();
          }
          return IconSend();
        }),


      ],
    );
  }
}


class IconSend extends GetView<ChatController> {
  @override
  Widget build(BuildContext context) {
    return Obx((){
      if(!controller.showMic.value){
        return Positioned(bottom: 12,right: 10,child: Container(
          color: Colors.transparent,
          width: 30.sp,
          height: 30.sp,
          child: FloatingActionButton(onPressed: (){
            controller.sendMessage();
          },child: Icon(Icons.send),),
        ),);
      }
      return RecordButton();
    });
  }
}




class RecordButton extends GetView<ChatRecordVoice> {
  @override
  Widget build(BuildContext context) {
    return Obx((){


      return Positioned(bottom: -15,right: -15,child: GestureDetector(
        onTap: ()async{
          if(!await controller.permissionOk()){
            return;
          }
        },
        onLongPressStart: (s)async{

          if(!await controller.permissionOk()){
            return;
          }

          controller.startRecord();
        },
        onLongPressEnd: (e){
          controller.stop();
        },
        child: Material(
          color: Colors.transparent,
          child: Container(
            child: Lottie.asset("assets/animations/record_voice.json",
                controller: controller.animation,
                width: 70.sp,height: 70.sp,
                repeat: controller.isRecording.value,
                animate: controller.isRecording.value
            ) ,
          ),
        ),
      ));

    });
  }
}