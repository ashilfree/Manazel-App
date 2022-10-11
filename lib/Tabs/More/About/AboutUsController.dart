

import 'package:get/get.dart';
import 'package:manazel_alabrar/Api/Api.dart';
import 'package:manazel_alabrar/model/AboutUs.dart';

class AboutUsController extends GetxController{

  RxBool loading = true.obs;
  Rx<AboutUs> aboutUs = Rx<AboutUs>(AboutUs());

  getAboutUs()async{
    loading.value = true;
    print(Url.url+Url.get_about_us);
    try{
      dynamic data = await Api().get(Url.url+Url.get_about_us,queryParams: {"lang":Get.locale.languageCode},withAuthorization: false);
      aboutUs.value = new AboutUs.fromJson(data["success"]);
      loading.value  = false;
    } catch(err){
      print("err : " + err.toString());
      loading.value  = false;
    }
  }

  @override
  void onInit() {
    getAboutUs();
    super.onInit();
  }

}