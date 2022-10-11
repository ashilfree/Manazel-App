

import 'package:get/get.dart';
import 'package:manazel_alabrar/Api/Api.dart';
import 'package:manazel_alabrar/BottomBar/MainController.dart';
import 'package:manazel_alabrar/BottomBar/MainScreen.dart';
import 'package:manazel_alabrar/Firebase/FirebaseController.dart';
import 'package:manazel_alabrar/Helper/Storage.dart';
import 'package:manazel_alabrar/Tabs/Home/HomeController.dart';
import 'package:manazel_alabrar/model/User.dart';

class MoreController extends GetxController{


  logOut(User user)async{
    FirebaseController.unSubscribeAll();
    var result = Api().post(Url.url+Url.logout,token: user.token.accessToken);
    Get.find<MainController>().currentIndex.value = 0;
    await Storage.removeUser();
    user.fromJson(null);
    Get.reset();
    // await Future.delayed(Duration(milliseconds: 150));
    Get.offAllNamed(MainScreen.routeName,arguments: 1);
  }


}