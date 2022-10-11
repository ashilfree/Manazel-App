import 'dart:io';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_audio_recorder/flutter_audio_recorder.dart';
import 'package:get/get.dart';
import 'package:manazel_alabrar/Chat/Controller/ChatController.dart';
import 'package:manazel_alabrar/Helper/MyTranslations.dart';
import 'package:manazel_alabrar/Helper/Storage.dart';
import 'package:manazel_alabrar/model/MessageType.dart';
import 'package:manazel_alabrar/model/User.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:manazel_alabrar/Api/Api.dart';
import 'package:manazel_alabrar/Firebase/FirebaseController.dart';
import 'package:dio/dio.dart' as dio;
import 'package:provider/provider.dart';




class ChatRecordVoice extends GetxController with SingleGetTickerProviderMixin {
  RxBool loading = false.obs;
  RecorderVoice recorderVoice = new RecorderVoice();
  RxBool isRecording = false.obs;
  RxBool isReadyToSendRecord = false.obs;
  File file;
  RxString time = RxString("00:00");

  Animation<double> animation;
  AnimationController animationController;

  initAnimation() {
    animationController =
        AnimationController(vsync: this, duration: Duration(seconds: 5));
    animation =
        Tween<double>(begin: 0.0, end: 1.0).animate(animationController);
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  void startRecord() async {
    if (file != null) {
      await file.delete(recursive: true);
    }
    isReadyToSendRecord.value = false;
    isRecording.value = true;
    animationController.repeat();
    recorderVoice.startRecording();
  }

  void stop() async {
    if (!isRecording.value) {
      return;
    }
    animationController.stop();
    animationController.reset();
    File stop = await recorderVoice.stop();
    if (stop != null) {
      File file2 = new File(stop.path);
      this.file = file2;
    }
    isReadyToSendRecord.value = true;
    isRecording.value = false;
  }

  void delete() async {
    isRecording.value = false;
    isReadyToSendRecord.value = false;
    file = await recorderVoice.stop();
    file.delete(recursive: true);
    file = null;
    time.value = "00:00";
  }

  @override
  void onClose() {
    recorderVoice?.dipose();
    print("onClose ---------------- ");
    super.onClose();
  }

  void handleTouch() async {
    if (!await FlutterAudioRecorder.hasPermissions) {
      return;
    }
    isRecording.value = true;
  }

  @override
  void onInit() {
    recorderVoice.stream_On_Time_RecordListener.stream.listen((event) {
      time.value = event;
    });
    initAnimation();
    super.onInit();
  }


  Future<bool> permissionOk() async {
    if(Platform.isIOS){
      bool mic = await FlutterAudioRecorder.hasPermissions;
      if(mic && !await Storage.permissionMicExist()){
        Storage.setPermissionMicOk();
        return false;
      }
      return mic;
    }
    bool permissions = await Permission.storage.isGranted && await Permission.microphone.isGranted;
    bool mic = await FlutterAudioRecorder.hasPermissions;
    return permissions;
  }


  void sendRecord() async {
    // set_rec_message
    if (file == null) {
      return;
    }
    isReadyToSendRecord.value = false;
    String fileName = file.path.split('/').last;
    dynamic data = await Api().post(Url.url + Url.set_rec_message,
        data: {
          "si": Get.find<ChatController>().student.id.toString(),
          "message": null,
          "lang": Get.locale.languageCode,
          "record_duration": 0,
          "file": await dio.MultipartFile.fromFile(
            file.path,
            filename: fileName,
          ),
        },
        queryParams: {
          "lang": Get.locale.languageCode,
          "si": Get.find<ChatController>().student.id.toString(),
        },
        withAuthorization: true);

      FirebaseMessaging.instance.sendToTopic(
          Get.find<ChatController>().student.id.toString(),
          isArabic ? "رساله صوتية" : "Message Voice",
          senderName: Get.context.read<User>().username,
          messageType: MessageType.audio,
          senderId: Get.find<ChatController>().student.id.toString()
      );

  }
}
