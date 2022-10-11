

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:manazel_alabrar/Firebase/FirebaseController.dart';
import 'package:manazel_alabrar/Firebase/NotificationController.dart';
import 'package:manazel_alabrar/Tabs/Home/HomeController.dart';
import 'package:manazel_alabrar/Tabs/Home/HomeScreen.dart';
import 'package:manazel_alabrar/Tabs/More/more_tab/MoreScreen.dart';
import 'package:manazel_alabrar/Tabs/MyAccount/my_account/MyAccountScreen.dart';
import 'package:manazel_alabrar/Tabs/MyStudent/Groups/MyStudentGroupScreen.dart';
import 'package:manazel_alabrar/Tabs/MyStudent/Students/MyStudentScreen.dart';
import 'package:manazel_alabrar/Tabs/MyTeacher/MyTeacherScreenAfterLogin.dart';
import 'package:manazel_alabrar/model/User.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';



class MainController extends GetxController{


  final List<Widget> screen = [];
  RxInt currentIndex = 0.obs;
  RxBool showBadge = true.obs;
  PageController pageController;



  @override
  void onInit() {


    if(!Get.context.read<User>().isNull){
      FirebaseMessaging.onBackgroundMessage(FirebaseController.backGroundMessage);
      NotificationController.init();
      FirebaseController.init();
    }


    screen.add(HomeScreen());

    if(!Get.context.read<User>().isNull){
      if(Get.context.read<User>().isTeacher){
        screen.add(MyStudentGroupScreen());
      }else{
        screen.add(MyTeacherScreen());
      }
    }

    screen.add(MyAccountScreen());
    screen.add(MoreTab());
    pageController = PageController(keepPage: true,initialPage: currentIndex.value);
    super.onInit();
  }


  @override
  void onReady() {
    if(Get.arguments!=null){
       changePage(Get.arguments);
    }
    changePage(0);
    super.onReady();
  }


  void changePage(int index) {
    currentIndex.value = index;
    pageController?.animateToPage(currentIndex.value,duration: Duration(milliseconds: 1), curve: Curves.easeOut);
    if(currentIndex.value != 0){
      Get.find<HomeController>()?.videoCustom?.stop();
    }
  }


}