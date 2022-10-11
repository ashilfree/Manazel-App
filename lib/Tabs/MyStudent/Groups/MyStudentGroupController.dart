
import 'package:get/get.dart';
import 'package:manazel_alabrar/Api/Api.dart';
import 'package:manazel_alabrar/model/Group.dart';


class MyStudentGroupController extends GetxController{

  RxBool loading = true.obs;
  RxList<Group> listGroups = RxList<Group>([]);
  Group groupSelected;

  getMyGroups()async{
    loading.value = true;
    try{
      dynamic data = await Api().get(Url.url+Url.teacher_groups,queryParams: {"lang":Get.locale.languageCode},withAuthorization: true);

      print(data.toString());
      for(dynamic json in data["groups"]){
        listGroups.add(Group.fromJson(json));
      }

      loading.value  = false;
    } catch(err){
      print("err : " + err.toString());
      loading.value  = false;
    }
  }

  @override
  void onInit() {
    getMyGroups();
    super.onInit();
  }


}