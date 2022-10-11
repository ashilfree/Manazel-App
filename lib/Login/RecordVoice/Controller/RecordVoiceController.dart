
import 'dart:io';
import 'package:flutter_audio_recorder/flutter_audio_recorder.dart';
import 'package:get/get.dart';
import 'package:manazel_alabrar/Api/Api.dart';
import 'package:manazel_alabrar/BottomBar/MainController.dart';
import 'package:manazel_alabrar/BottomBar/MainScreen.dart';
import 'package:manazel_alabrar/Firebase/FirebaseController.dart';
import 'package:manazel_alabrar/Helper/Messages.dart';
import 'package:manazel_alabrar/Helper/Storage.dart';
import 'package:manazel_alabrar/Login/SignUp/SignUpController.dart';
import 'package:manazel_alabrar/model/Result.dart';
import 'package:manazel_alabrar/model/Token.dart';
import 'package:manazel_alabrar/model/User.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:dio/dio.dart' as dio;
import 'package:provider/provider.dart';



class RecordVoiceController extends GetxController{

  RxBool loading = false.obs;
  RecorderVoice recorderVoice = new RecorderVoice();
  RxBool isRecording = false.obs;
  File file;
  RxString time = RxString("00:00");



  void startRecord() async{
    if(file!=null){
       await file.delete(recursive: true);
    }
    isRecording.value = true;
    recorderVoice.startRecording();
  }


  void stop() async{
    if(!isRecording.value){
      return;
    }
    File stop = await recorderVoice.stop();
    if(stop!=null){
      File file2 = new File(stop.path);
      this.file = file2;
    }
    isRecording.value = false;
  }


  void delete() async{
    isRecording.value = false;
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


  void handleTouch() async{
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



  void signUp() {

    if(file==null){
      error("يجب عليك تسجيل الاختبار اولا");
      return;
    }

    if(Get.find<SignUpController>().isTeacher.value){
      signUpTeacher();
    }else{
      signUpStudent();
    }
  }

  signUpTeacher()async{

    loading.value = true;

    try{
      var data = {
        "username":Get.find<SignUpController>().username.text,
        "password":Get.find<SignUpController>().password.text,
        "email":Get.find<SignUpController>().email.text,
        "phoneNumber":Get.find<SignUpController>().phoneNumber.text,
        "bDate":Get.find<SignUpController>().bDate.text,
        "type":"teacher",
        "quranParts":Get.find<SignUpController>().quranParts.text,
        "availableTimes":Get.find<SignUpController>().availableTimes.text,
        "workingHours":Get.find<SignUpController>().workingHours.text,
        "mastery_certificates":Get.find<SignUpController>().mastery_certificates.text,
        "file":await dio.MultipartFile.fromFile(
          file.path,
          filename:file.path.split('/').last,
        ),
        "country_id":Storage.getCountry().id,
        "mogazh":Get.find<SignUpController>().mogazah.value ? 1 : 0,
      };

      data.forEach((key, value) {
        print(key.toString() + "  " + value.toString());
      });

      dynamic json = await Api().post(Url.url+Url.registerTeacher,data:data ,withAuthorization: false);

      ResultApi result = ResultApi.fromJson(json);

      if(result.state == 0){
        print("err : " + result.error);
        error(result.error);
        loading.value  = false;
        return;
      }

      getDataUser(Token.fromJson(json));
    } catch(err){
      print("err : " + err.toString());
      loading.value  = false;
    }
  }


  signUpStudent()async{
    loading.value = true;
    try{
      dynamic json = await Api().post(Url.url+Url.registerStudent,data: {
        "username":Get.find<SignUpController>().username.text,
        "password":Get.find<SignUpController>().password.text,
        "email":Get.find<SignUpController>().email.text,
        "phoneNumber":Get.find<SignUpController>().phoneNumber.text,
        "bDate":Get.find<SignUpController>().bDate.text,
        "type":"student",
        "quranParts":Get.find<SignUpController>().quranParts.text,
        "file":await dio.MultipartFile.fromFile(
          file.path,
          filename:file.path.split('/').last,
        ),
        "country_id":Storage.getCountry().id,
      },withAuthorization: false);

      ResultApi result = ResultApi.fromJson(json);

      if(result.state == 0){
        print("err : " + result.error);
        error(result.error);
        loading.value  = false;
        return;
      }

      getDataUser(Token.fromJson(json));
    } catch(err){
      print("err : " + err.toString());
      loading.value  = false;
    }
  }


  void getDataUser(Token token) async{

    Get.context.read<User>().token = token;

    loading.value = true;

    try{
      dynamic json = await Api().get(Url.url+Url.user,token: token.accessToken);

      ResultApi result = ResultApi.fromJson(json);

      if(result.state == 0){
        print("err : " + result.error);
        error(result.error);
        loading.value  = false;
        return;
      }

      Get.context.read<User>().fromJson(json,isNewUser: true);
      await Storage.saveUser(Get.context.read<User>().toJson());


      if(Get.context.read<User>().isTeacher){
        FirebaseController.subScribeTeachers();
      }else{
        FirebaseController.subScribeStudent();
      }

      Get.reset();
      await Future.delayed(Duration(milliseconds: 150));
      Get.offAllNamed(MainScreen.routeName);

    } catch(err){
      print("err : " + err.toString());
      loading.value  = false;
    }
  }


}