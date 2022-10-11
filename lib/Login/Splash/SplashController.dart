

import 'package:get/get.dart';
import 'package:manazel_alabrar/BottomBar/MainScreen.dart';
import 'package:manazel_alabrar/Helper/Storage.dart';
import 'package:manazel_alabrar/Login/Intro/IntroScreen.dart';

class SplashController extends GetxController{


  RxBool start = false.obs;

  checkFirstSeen()async{
    if(await Storage.countryExist()){
      Get.toNamed(MainScreen.routeName);
      return;
    }
    Get.toNamed(IntroScreen.routeName);
  }


  @override
  void onInit() {
    Future.delayed(Duration(seconds: 5),(){
      checkFirstSeen();
    });
    super.onInit();
  }


}