
import 'package:get/get.dart';
import 'package:manazel_alabrar/Api/Api.dart';
import 'package:manazel_alabrar/model/Result.dart';
import 'package:manazel_alabrar/model/Teacher.dart';



class MyTeacherController extends GetxController{

  RxBool loading = false.obs;
  Teacher teacher;

  void getTeacher() async{
    try{
      loading.value = true;
      String url = Url.url+Url.get_teacher;
      dynamic data = await Api().get(url, queryParams: {"lang":Get.locale.languageCode}, withAuthorization: true);
      ResultApi resultApi = ResultApi.fromJson(data);
      if(resultApi.state == 1){
        teacher = Teacher.fromJson(data["success"]);
      }
      loading.value = false;
    } catch(err){
      print("err : " + err.toString());
      loading.value = false;
    }
  }


  @override
  void onInit() {
     getTeacher();
    super.onInit();
  }

}