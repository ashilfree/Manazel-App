import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:manazel_alabrar/BottomBar/MainController.dart';
import 'package:manazel_alabrar/BottomBar/MainScreen.dart';
import 'package:manazel_alabrar/Helper/Language.dart';
import 'package:manazel_alabrar/Login/Intro/IntroController.dart';
import 'package:manazel_alabrar/Tabs/More/AppGuideliens/AppGuidelinesScreen.dart';
import 'package:manazel_alabrar/Helper/CustomAlertDialog.dart';
import 'package:manazel_alabrar/Tabs/More/Changelanguage/ChangeLanguageController.dart';




class IntroScreen extends GetView<IntroController> {

  static const String routeName = "IntroScreen";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff8d7249),
      body: Stack(
        children: [
          Align(
              alignment: Alignment.bottomCenter,
              child: Image.asset('assets/images/bottom_img.png')),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(
                    child: Image.asset(
                      'assets/images/c_logo.png',
                      height: 150,
                      width: 150,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  Text(
                   "intro.chooseLanguage".tr,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  InkWell(
                    onTap: () {
                      showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return SelectLanguageDialog();
                          });
                    },
                    child: Container(
                      height: 50,
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Color(0xff8d7249),
                        borderRadius: BorderRadius.circular(5),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.5),
                            spreadRadius: 3,
                            blurRadius: 3,
                            offset: Offset(0, 3), // changes position of shadow
                          ),
                        ],
                      ),
                      child: LanguageWidget(),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "intro.chooseCountry".tr,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  InkWell(
                    onTap: () {
                      if(controller.listCountry.isEmpty){
                         controller.getCountry();
                      }
                      showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return StatefulBuilder(builder: (context, setState) {
                              return SelectCountryDialog();
                            });
                          });
                    },
                    child: Container(
                      height: 50,
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Color(0xff8d7249),
                        borderRadius: BorderRadius.circular(5),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.5),
                            spreadRadius: 3,
                            blurRadius: 3,
                            offset: Offset(0, 3), // changes position of shadow
                          ),
                        ],
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [

                          Obx((){
                            if(controller.countrySelected.value == null){
                              return Text("intro.selectCountry".tr,
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18));
                            }
                            return Text(
                                controller.countrySelected.value.getName(),
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18));
                          }),

                          Row(
                            children: [
                              Obx((){
                                if(controller.countrySelected.value == null){
                                  return Container();
                                }
                                return Image.asset(
                                  controller.countrySelected.value.image,
                                  height: 40,
                                  width: 40,
                                );
                              }),
                              Image.asset(
                                'assets/images/click arrow.png',
                                height: 20,
                                width: 20,
                              ),
                            ],
                          ),



                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  InkWell(
                    onTap: (){
                       // Get.toNamed(AppGuidelinesScreen.routeName);
                      if(controller.countrySelected.value == null){
                        return;
                      }
                      Get.toNamed(MainScreen.routeName);
                    },
                    child: Container(
                      height: 50,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          border:
                          Border.all(color: Color(0xff8d7249), width: 2),
                          borderRadius: BorderRadius.circular(5)),
                      child: Text(
                        "intro.CONTINUE".tr,
                        style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                            color: Color(0xff8d7249)),
                      ),
                    ),
                  )
                ]),
          ),
        ],
      ),
    );
  }
}

class LanguageWidget extends GetView<ChangeLanguageController> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Obx((){
          if(controller.languageSelected.value == null){
            return Text("intro.selectLanguage".tr,
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 18));
          }
          return Text(controller.languageSelected.value.name,
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 18));
        }),
        Image.asset(
          'assets/images/click arrow.png',
          height: 20,
          width: 20,
        )
      ],
    );
  }
}


