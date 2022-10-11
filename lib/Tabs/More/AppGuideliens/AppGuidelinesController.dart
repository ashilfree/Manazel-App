

import 'package:carousel_slider/carousel_slider.dart';
import 'package:get/get.dart';
import 'package:manazel_alabrar/Api/Api.dart';
import 'package:manazel_alabrar/Tabs/More/AppGuideliens/AppGuidelinesScreen.dart';
import 'package:manazel_alabrar/model/AppGuidLine.dart';


class AppGuidelinesController extends GetxController{


  CarouselController carouselController = new CarouselController();
  RxInt current = 0.obs;

  RxBool loading = true.obs;
  RxList<AppGuidLine> appGuidLine = RxList<AppGuidLine>([]);


  getAppGuidLine()async{
    loading.value = true;
    try{
      dynamic data = await Api().get(Url.url+Url.get_app_guide,queryParams: {"lang":Get.locale.languageCode},withAuthorization: true);
      for(dynamic json in data["success"]){
        appGuidLine.add(new AppGuidLine.fromJson(json));
      }
      loading.value  = false;
    } catch(err){
      print("err : " + err.toString());
      loading.value  = false;
    }
  }


  @override
  void onInit() {
    getAppGuidLine();
    super.onInit();
  }


}