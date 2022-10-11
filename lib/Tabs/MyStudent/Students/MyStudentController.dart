
import 'package:get/get.dart';
import 'package:manazel_alabrar/Api/Api.dart';
import 'package:manazel_alabrar/Helper/CustomAlertDialog.dart';
import 'package:manazel_alabrar/Tabs/MyStudent/Groups/MyStudentGroupController.dart';
import 'package:manazel_alabrar/model/Result.dart';
import 'package:manazel_alabrar/model/Student.dart';

class MyStudentController extends GetxController{

  RxBool loading = false.obs;
  RxBool loadingMoveNextWeek = false.obs;
  RxList<Student> listStudent = RxList<Student>([]);


  getListStudent()async{
    loading.value = true;
    try{
      dynamic data = await Api().get(Url.url+Url.group_students,queryParams: {"lang":Get.locale.languageCode,"group":Get.find<MyStudentGroupController>().groupSelected.id},withAuthorization: true);
      for(dynamic json in data["students"]){
        listStudent.add(Student.fromJson(json));
      }
      loading.value  = false;
    } catch(err){
      print("err : " + err.toString());
      loading.value  = false;
    }
  }

  moveNextWeek()async{
    if(loadingMoveNextWeek.value){
       return;
    }
    loadingMoveNextWeek.value = true;
    try{
      dynamic data = await Api().get(Url.url+Url.move_to_next_week, queryParams: {"lang":Get.locale.languageCode, "group":Get.find<MyStudentGroupController>().groupSelected.id},withAuthorization: true);
      print(data.toString());
      ResultApi resultApi = ResultApi.fromJson(data);
      customAlertBox(Get.context,resultApi.message);
      loadingMoveNextWeek.value  = false;
    } catch(err){
      print("err : " + err.toString());
      loadingMoveNextWeek.value  = false;
    }
  }

  @override
  void onInit() {
    getListStudent();
    super.onInit();
  }

}