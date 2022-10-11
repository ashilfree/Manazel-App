

import 'package:get/get.dart';
import 'package:manazel_alabrar/Api/Api.dart';
import 'package:manazel_alabrar/Api/Url.dart';
import 'package:manazel_alabrar/model/Assignment.dart';
import 'package:manazel_alabrar/model/Result.dart';

class MyAssignmentController extends GetxController{

  RxBool loading = true.obs;
  Rx<Assignment> assignment = Rx<Assignment>(null);
  ResultApi resultApi;

  getAssignment()async{
    loading.value = true;
    try{
      dynamic data = await Api().get(Url.url+Url.assignment,queryParams: {"lang":Get.locale.languageCode},withAuthorization: true);
      print(data.toString());
      resultApi = ResultApi.fromJson(data);
      for(dynamic json in data["assignments"]){
        print(json);
        assignment.value = Assignment.fromJson(json);
      }
      loading.value  = false;
    } catch(err){
      print("err : " + err.toString());
      loading.value  = false;
    }
  }


  @override
  void onInit() {
    getAssignment();
    super.onInit();
  }


}