import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:manazel_alabrar/Helper/Screen.dart';
import 'package:manazel_alabrar/Login/Forget/ForgetScreen.dart';
import 'package:manazel_alabrar/Login/SignIn/SignInController.dart';
import 'package:manazel_alabrar/Login/SignUp/SignUpScreen.dart';



class SignIn extends GetView<SignInController> {

  static const String routeName = "SignIn";
  const SignIn({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [

            Container(
              height: isPortal ? Get.height * 55 / 100 : Get.width * 55 / 100,
              padding: EdgeInsets.only(right: 20,left: 20,top: 40,bottom: 20),
              decoration: BoxDecoration(
                  image: DecorationImage(
                      colorFilter: new ColorFilter.mode(
                          Color(0xff8d7249).withOpacity(0.5), BlendMode.darken),
                      image: AssetImage('assets/images/quran_image.png'),
                      fit: BoxFit.cover)),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "signIn.login".tr,
                      style: TextStyle(
                          fontSize: 22,
                          color: Colors.white,
                          fontWeight: FontWeight.w700),
                    ),
                    Expanded(
                      flex: 2,
                      child: Form(
                        key: controller.from,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            TextFormField(
                                controller: controller.name,
                                validator: (text){
                                  if(text.isEmpty){
                                    return "signIn.selectName".tr;
                                  }
                                  return null;
                                },
                                decoration: InputDecoration(
                                  hintText: "signIn.name".tr,
                                )),
                            SizedBox(
                              height: 10,
                            ),
                            TextFormField(
                                controller: controller.password,
                                validator: (text){
                                  if(text.isEmpty){
                                    return "signIn.selectPassword".tr;
                                  }
                                  return null;
                                },
                                obscureText: true,
                                decoration: InputDecoration(
                                  hintText: "signIn.password".tr,
                                )),
                          ],
                        ),
                      ),
                    ),

                    Align(
                      alignment: Alignment.centerLeft,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            margin: EdgeInsets.only(left: 5),
                            height: 20,
                            width: 20,
                            color: Colors.white,
                            child: Obx((){
                              return Checkbox(
                                value: controller.rememberMe.value,
                                onChanged: (value) {
                                  controller.rememberMe.value = value;
                                },
                              );
                            }),
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            "signIn.rememberMe".tr,
                            style:
                            TextStyle(fontSize: textSize(3.8), color: Colors.white),
                          ),
                        ],
                      ),
                    ),


                    Expanded(
                      flex: 1,
                      child: Obx((){
                        return AnimatedSwitcher(duration: Duration(milliseconds: 300),
                          child: controller.loading.value ? CircularProgressIndicator() : OutlinedButton(
                            onPressed: () {
                              controller.signIn();
                            },
                            child: Text(
                              "signIn.signIn".tr,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),);
                      }),
                    ),


                  ]),
            ),


            Container(
              margin: EdgeInsets.symmetric(horizontal: 20),
              height: isPortal ? Get.height * 30 / 100 : Get.width * 30 / 100,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [

                  Text(
                    "signIn.create".tr,
                    style: TextStyle(
                        fontSize: textSize(5.0),
                        fontWeight: FontWeight.w500,
                        color: Colors.grey[800]),
                  ),

                  Container(
                    height: 50,
                    width: Get.width,
                    child: ElevatedButton.icon(
                      icon: Image.asset("assets/images/teacher_logo.png"),
                      label: Expanded(child: Text("signIn.youAreTeacher".tr,textAlign: TextAlign.center,style: TextStyle(
                          fontSize: 30,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),),),
                      onPressed: () {
                        Get.toNamed(SignUpScreen.routeName,arguments: {"isTeacher":true});
                      },
                    ),
                  ),

                  Container(
                    height: 50,
                    width: Get.width,
                    child: ElevatedButton.icon(
                      icon: Image.asset("assets/images/student_logo.png"),
                      label: Expanded(child: Text("signIn.youAreStudent".tr,textAlign: TextAlign.center,style: TextStyle(
                          fontSize: 30,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),),),
                      onPressed: () {
                        Get.toNamed(SignUpScreen.routeName,arguments: {"isTeacher":false});
                      },
                    ),
                  ),

                ],
              ),
            ),

          ],
        ),
      ),
    );

  }
}






