import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:manazel_alabrar/Helper/Language.dart';
import 'package:manazel_alabrar/Helper/Loading.dart';
import 'package:manazel_alabrar/Login/Intro/IntroController.dart';
import 'package:manazel_alabrar/Tabs/More/Changelanguage/ChangeLanguageController.dart';
import 'package:manazel_alabrar/Tabs/MyAccount/my_account/MyAccountController.dart';
import 'package:manazel_alabrar/model/Country.dart';
import 'package:manazel_alabrar/model/MyLevel.dart';



customAlertBox(context, title) {
  if(Get.isDialogOpen){
    return;
  }
  Get.dialog(Center(
    child: Container(
      height: MediaQuery.of(context).size.height * 0.35,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            width: MediaQuery.of(context).size.width * 0.8,
            height: MediaQuery.of(context).size.height * 0.2,
            padding: EdgeInsets.all(10),
            color: Colors.white,
            child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Material(
                    child:Text(
                      title,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 17, fontWeight: FontWeight.w600),
                    )
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  OutlinedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    style: OutlinedButton.styleFrom(
                        backgroundColor: Color(0xff8d7249)),
                    child: Text(
                      "button.CONTINUE".tr,
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    ),
                  )
                ]),
          ),
          Positioned(
            top: 5,
            child: CircleAvatar(
              radius: 50,
              backgroundColor: Colors.white,
              child: Image.asset(
                'assets/images/c_logo.png',
                height: 70,
                width: 70,
              ),
            ),
          ),
        ],
      ),
    ),
  ));
}

enum ChooseLanguage { Arabic, English }
ChooseLanguage chooseLanguage = ChooseLanguage.English;



enum ChooseCountry {
  Egypt,
  Kuwait,
  Jordan,
  Algeria,
  Lebanon,
  Oman,
  Qatar,
  SaudiArabia,
  Syria,
  Iraq,
  Bahrain,
  Sudan,
  Palestine
}
String countryFlag = '';
ChooseCountry chooseCountry = ChooseCountry.Kuwait;


class SelectCountryDialog extends GetView<IntroController> {
  @override
  Widget build(BuildContext context) {
    return Obx((){
      return Center(
        child: Container(
          height: MediaQuery.of(context).size.height * 0.8,
          child: Stack(
            alignment: Alignment.center,
            children: [
              Container(
                constraints: BoxConstraints(
                  minHeight: MediaQuery.of(context).size.height * 0.65,
                  maxHeight: MediaQuery.of(context).size.height * 0.65,
                  maxWidth: MediaQuery.of(context).size.width * 0.8,
                  minWidth: MediaQuery.of(context).size.width * 0.8,
                ),
                padding: EdgeInsets.all(10),
                color: Colors.white,
                child: Card(
                  elevation: 0,
                  child: controller.loadingCountry.value ? CircularProgressIndicator()  : ListView.builder(
                      itemCount: controller.listCountry.length,
                      itemBuilder: (c,index){
                        Country country = controller.listCountry[index];
                        return ListTile(
                          onTap: (){
                            controller.selectCountry(country);
                            Navigator.pop(context);
                          },
                          title: Text(
                            country.getName(),
                            style: TextStyle(fontSize: 18),
                          ),
                          leading: Image.asset(
                            country.image,
                            height: 50,
                            width: 50,
                          ),
                          trailing: controller.isCountrySelected(country) ? Icon(Icons.check_circle_rounded) : null,
                        );
                      }),
                ),
              ),
              Positioned(
                top: 0,
                child: CircleAvatar(
                  radius: 50,
                  backgroundColor: Colors.white,
                  child: Image.asset(
                    'assets/images/c_logo.png',
                    height: 70,
                    width: 70,
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}




class SelectLanguageDialog extends GetView<ChangeLanguageController> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: MediaQuery.of(context).size.height * 0.5,
        child: Stack(
          alignment: Alignment.center,
          children: [
            Container(
              constraints: BoxConstraints(
                minHeight: MediaQuery.of(context).size.height * 0.33,
                maxHeight: MediaQuery.of(context).size.height * 0.33,
                maxWidth: MediaQuery.of(context).size.width * 0.8,
                minWidth: MediaQuery.of(context).size.width * 0.8,
              ),
              padding: EdgeInsets.all(10),
              color: Colors.white,
              child: Card(
                elevation: 0,
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      SizedBox(
                        height: 30,
                      ),
                      Text(
                        "intro.chooseLanguage".tr,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 24, fontWeight: FontWeight.w600),
                      ),
                      Expanded(
                        flex: 2,
                        child: ListView.builder(
                            itemCount: Language.list.length,
                            itemBuilder: (context,index){
                              Language la = Language.list[index];
                              return ListTile(
                                onTap: (){
                                  controller.changeLanguage(la);
                                  Navigator.pop(context);
                                },
                                title: Text(
                                  la.name,
                                  style: TextStyle(fontSize: 18),
                                ),
                                trailing: controller.isCountryLanguage(la) ? Icon(Icons.check_circle_rounded) : null,
                              );
                            }),
                      ),
                    ]),
              ),
            ),
            Positioned(
              top: 10,
              child: CircleAvatar(
                radius: 50,
                backgroundColor: Colors.white,
                child: Image.asset(
                  'assets/images/c_logo.png',
                  height: 70,
                  width: 70,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}





class SetLevelDialog extends StatelessWidget {
  final MyAccountController controller;
  const SetLevelDialog({Key key, this.controller}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: MediaQuery.of(context).size.height * 0.5,
        child: Stack(
          alignment: Alignment.center,
          children: [
            Container(
              constraints: BoxConstraints(
                minHeight: MediaQuery.of(context).size.height * 0.33,
                maxHeight: MediaQuery.of(context).size.height * 0.33,
                maxWidth: MediaQuery.of(context).size.width * 0.8,
                minWidth: MediaQuery.of(context).size.width * 0.8,
              ),
              padding: EdgeInsets.all(10),
              color: Colors.white,
              child: Card(
                elevation: 0,
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      SizedBox(
                        height: 30,
                      ),
                      Text(
                        "myAccount.SelectLevel".tr,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 24, fontWeight: FontWeight.w600),
                      ),
                      Expanded(
                        flex: 2,
                        child: Obx((){
                          if(controller.loadingSubLevelList.value){
                            return LoadingPage();
                          }
                          return ListView.builder(
                              itemCount: controller.listSubLevel.length,
                              itemBuilder: (context,index){
                                SubLevel subLevel = controller.listSubLevel[index];
                                return ListTile(
                                  onTap: (){
                                    controller.setSubLevel(subLevel);
                                    Navigator.pop(context);
                                  },
                                  title: Text(
                                    subLevel.name,
                                    style: TextStyle(fontSize: 18),
                                  ),
                                  leading: Image.asset(
                                    "assets/images/level_icon.png",
                                    height: 50,
                                    width: 50,
                                  ),
                                );
                              });
                        }),
                      ),
                    ]),
              ),
            ),
            Positioned(
              top: 10,
              child: CircleAvatar(
                radius: 50,
                backgroundColor: Colors.white,
                child: Image.asset(
                  'assets/images/c_logo.png',
                  height: 70,
                  width: 70,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}