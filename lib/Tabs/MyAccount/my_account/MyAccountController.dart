



import 'dart:io';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:manazel_alabrar/Api/Api.dart';
import 'package:manazel_alabrar/Helper/CustomAlertDialog.dart';
import 'package:manazel_alabrar/Helper/Loading.dart';
import 'package:manazel_alabrar/Helper/Storage.dart';
import 'package:manazel_alabrar/model/MyLevel.dart';
import 'package:manazel_alabrar/model/Result.dart';
import 'package:manazel_alabrar/model/User.dart';
import 'package:path_provider/path_provider.dart' as path_provider;
import 'package:dio/dio.dart' as dio;
import 'package:provider/provider.dart';

class MyAccountController extends GetxController{




  Rx<File> image = Rx<File>(null);
  RxBool loadingLevel = false.obs;
  RxBool loadingSubLevelList = false.obs;
  RxBool loadingSetLevel = false.obs;
  RxList<SubLevel> listSubLevel = RxList<SubLevel>([]);
  Rx<MyLevel> myLevel = Rx<MyLevel>(MyLevel());




  getLevel()async{

    Get.dialog(LoadingPage());

    loadingLevel.value = true;

    try{
      dynamic json = await Api().get(Url.url+Url.getLevel,queryParams: {"lang":Get.locale.languageCode},withAuthorization: true);

      ResultApi resultApi = ResultApi.fromJson(json);

      if(resultApi.state == 0){

        if(Get.isDialogOpen){
           Get.back();
        }

        loadingLevel.value  = false;
        customAlertBox(Get.overlayContext,resultApi.error.toString());
        return;
      }

      if(Get.isDialogOpen){
         Get.back();
      }


      myLevel.value = MyLevel.fromJson(json);
      loadingLevel.value  = false;


      if(myLevel.value.subLevel == null){
        customAlertBox(Get.context, "Your current level" + "\n" + "${myLevel.value.myLevel.getName()}");
      }else{
        customAlertBox(Get.context, "Your current level" + "\n" + "${myLevel.value.myLevel.getName()} -> ${myLevel.value.subLevel.getName()}");
      }

    } catch(err){

      print("err : " + err.toString());

      loadingLevel.value  = false;

    }

  }


  RxBool loadingUploadImage = false.obs;

  Future getImage() async {
    final pickedFile = await ImagePicker().getImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      image.value = await compressAndGetFile(File(pickedFile.path));
      updateImage();
    } else {
      print('No image selected.');
    }
  }


  Future<File> compressAndGetFile(File file) async {
    final dir = await path_provider.getTemporaryDirectory();
    final targetPath = dir.absolute.path +"/${DateTime.now().millisecondsSinceEpoch.toString()}.jpg";
    var result = await FlutterImageCompress.compressAndGetFile(
      file.absolute.path, targetPath,
      quality: 50,
      rotate: 0,
    );
    return result;
  }

  getSubLevels()async{

    Get.dialog(LoadingPage());

    loadingSubLevelList.value = true;

    try{

      dynamic json = await Api().get(Url.url+Url.get_sub_levels,queryParams: {"lang":Get.locale.languageCode},withAuthorization: true);

      ResultApi resultApi = ResultApi.fromJson(json);

      if(resultApi.state == 0){

        if(Get.isDialogOpen){
          Get.back();
        }

        loadingSubLevelList.value  = false;
        customAlertBox(Get.overlayContext,resultApi.error.toString());
        return;
      }

      if(Get.isDialogOpen){
        Get.back();
      }


      listSubLevel.clear();
      for(dynamic json in json["success"]){
        listSubLevel.add(SubLevel.fromJson(json));
      }

      Get.dialog(SetLevelDialog(controller: this,));
      loadingSubLevelList.value  = false;

    } catch(err){
      print("err : " + err.toString());
      loadingSubLevelList.value  = false;
    }

  }




  void setSubLevel(SubLevel subLevel) async{
    loadingSetLevel.value = true;
    try{
      var queryParams = {"lang":Get.locale.languageCode,"level_id":subLevel.id};
      dynamic json = await Api().get(Url.url+Url.set_sub_level,queryParams: queryParams,withAuthorization: true);
      ResultApi resultApi = ResultApi.fromJson(json);
      if(resultApi.state == 1){
        customAlertBox(Get.overlayContext,resultApi.success.toString());
      }else{
        customAlertBox(Get.overlayContext,resultApi.error.toString());
      }
      loadingSetLevel.value  = false;
    } catch(err){
      print("err : " + err.toString());
      loadingSetLevel.value  = false;
    }
  }


  void updateImage() async {
    // set_rec_message
    if (image.value == null) {
      return;
    }
    loadingUploadImage.value=true;
    try{
      String fileName = image.value.path.split('/').last;
      dynamic data = await Api().post(Url.url + Url.edit_photo,
          data: {
            "image": await dio.MultipartFile.fromFile(
              image.value.path,
              filename: fileName,
            ),
          },
          withAuthorization: true);
      ResultApi resultApi = ResultApi.fromJson(data);
      if(resultApi.state == 1){
        Get.context.read<User>().image = data["image"];
        await Storage.saveUser(Get.context.read<User>().toJson());
      }
      loadingUploadImage.value=false;
      print(data.toString());
    }catch(err){
      loadingUploadImage.value=false;
    }
  }



}