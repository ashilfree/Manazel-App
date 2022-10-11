import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:manazel_alabrar/BottomBar/MainController.dart';
import 'package:manazel_alabrar/Login/SignIn/SignInController.dart';
import 'package:manazel_alabrar/Tabs/Home/HomeController.dart';
import 'package:manazel_alabrar/Tabs/More/more_tab/MoreController.dart';
import 'package:manazel_alabrar/Tabs/MyAccount/my_account/MyAccountController.dart';
import 'package:manazel_alabrar/model/User.dart';
import 'package:sizer/sizer.dart';
import 'package:provider/provider.dart';



class MainScreen extends StatefulWidget {
  static const String routeName = "MainScreen";
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {


  var s2 = Get.put(HomeController());
  var s3 = Get.put(MyAccountController());
  var s4 = Get.put(MoreController());
  var s5 = Get.put(SignInController());

  @override
  Widget build(BuildContext context) {
    var s1 = Get.put(MainController());
    return _MainScreen();
  }
}


class _MainScreen extends GetView<MainController> {
  const _MainScreen({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text("nameApp".tr),
        centerTitle: true,
        leading: Container(
            margin: EdgeInsets.all(7),
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("assets/images/quran_readers.png"),
                    fit: BoxFit.cover))),
      ),
      body: Padding(
        padding: EdgeInsets.only(left: 0.0, right: 0.0),
        child:PageView(
          controller: controller.pageController,
          physics: NeverScrollableScrollPhysics(),
          children:controller.screen,
        ),
      ),


      bottomNavigationBar: Obx((){
        return BottomNavigationBar(
          enableFeedback: false,
          showSelectedLabels: true,
          showUnselectedLabels: true,
          items: getBottomBar(),
          currentIndex: controller.currentIndex.value,
          onTap: (index){
            controller.changePage(index);
          },
        );
      }),
    );
  }


  List<BottomNavigationBarItem> getBottomBar(){

    if(Get.context.read<User>().isNull){
      return [
        BottomNavigationBarItem(icon: Image.asset("assets/images/home_icon.png",filterQuality: FilterQuality.high,width: 17.sp,height: 17.sp,), label: "bottomBar.Home".tr,),
        BottomNavigationBarItem(icon: Image.asset("assets/images/my_account_icon_active.png",filterQuality: FilterQuality.high,width: 17.sp,height: 17.sp,), label: "bottomBar.My_Account".tr,),
        BottomNavigationBarItem(icon: Image.asset("assets/images/more_icon_active.png",filterQuality: FilterQuality.high,width: 17.sp,height: 17.sp,), label: "bottomBar.My_More".tr,),
      ];
    }

    if(Get.context.read<User>().isTeacher){
      return [
        BottomNavigationBarItem(icon: Image.asset("assets/images/home_icon.png",filterQuality: FilterQuality.high,width: 17.sp,height: 17.sp,), label: "bottomBar.Home".tr,),
        BottomNavigationBarItem(icon: Image.asset("assets/images/teacher_icon.png",filterQuality: FilterQuality.high,width: 17.sp,height: 17.sp,), label: "bottomBar.My_Student".tr,),
        BottomNavigationBarItem(icon: Image.asset("assets/images/my_account_icon_active.png",filterQuality: FilterQuality.high,width: 17.sp,height: 17.sp,), label: "bottomBar.My_Account".tr,),
        BottomNavigationBarItem(icon: Image.asset("assets/images/more_icon_active.png",filterQuality: FilterQuality.high,width: 17.sp,height: 17.sp,), label: "bottomBar.My_More".tr,)
      ];
    }

    return [
      BottomNavigationBarItem(icon: Image.asset("assets/images/home_icon.png",filterQuality: FilterQuality.high,width: 17.sp,height: 17.sp,), label: "bottomBar.Home".tr,),
      BottomNavigationBarItem(icon: Image.asset("assets/images/teacher_icon.png",filterQuality: FilterQuality.high,width: 17.sp,height: 17.sp,), label: "bottomBar.My_Teacher".tr,),
      BottomNavigationBarItem(icon: Image.asset("assets/images/my_account_icon_active.png",filterQuality: FilterQuality.high,width: 17.sp,height: 17.sp,), label: "bottomBar.My_Account".tr,),
      BottomNavigationBarItem(icon: Image.asset("assets/images/more_icon_active.png",filterQuality: FilterQuality.high,width: 17.sp,height: 17.sp,), label: "bottomBar.My_More".tr,)
    ];

  }


}




