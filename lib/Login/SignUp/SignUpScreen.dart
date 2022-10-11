import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:manazel_alabrar/Login/RecordVoice/Controller/RecordVoiceController.dart';
import 'package:manazel_alabrar/Login/RecordVoice/RecordVoiceScreen.dart';
import 'package:manazel_alabrar/Login/SignUp/SignUpController.dart';



class SignUpScreen extends GetView<SignUpController> {

  static const String routeName = "SignUpScreen";
  const SignUpScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    dynamic data = ModalRoute.of(context).settings.arguments;
    controller.isTeacher.value = data["isTeacher"];


    return Directionality(
      textDirection: TextDirection.ltr,
      child: Scaffold(
        body: Stack(
          children: [
            SS(),
            SingleChildScrollView(
              child: Column(
                children: [

                  Padding(
                    padding: const EdgeInsets.only(left: 20.0, right: 20, top: 50),
                    child: Center(
                      child: Form(
                        key: controller.from,
                        child: Column(
                          children: [

                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                InkWell(
                                  onTap: () {
                                    Navigator.pop(context);
                                  },
                                  child: Icon(
                                    Icons.arrow_back,
                                    size: 30,
                                    color: Color(0xff8d7249),
                                  ),
                                ),
                                Image.asset(
                                  'assets/images/c_logo.png',
                                  height: 120,
                                  width: 120,
                                ),
                                Text("")
                              ],
                            ),

                            SizedBox(
                              height: 30,
                            ),

                            TextFormField(
                              controller: controller.username,
                              validator: (text) {
                                if (text.isEmpty) {
                                  return "signIn.selectName".tr;
                                }
                                return null;
                              },
                              decoration: InputDecoration(
                                hintText: "signIn.name".tr,
                                prefixIcon: new Icon(Icons.person, color: Colors.white),
                                hintStyle: TextStyle(color: Color(0xff8d7249)),
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Stack(
                              children: [
                                TextFormField(
                                  controller: controller.email,
                                  keyboardType: TextInputType.emailAddress,
                                  decoration: InputDecoration(
                                    hintText: "signUp.email".tr,
                                    prefixIcon: new Icon(Icons.email, color: Colors.white),
                                    hintStyle: TextStyle(color: Color(0xff8d7249)),
                                  ),
                                ),
                                Positioned(
                                    right: 15,
                                    top: 0,
                                    bottom: 0,
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          "signUp.optional".tr,
                                          style: TextStyle(color: Color(0xff8d7249)),
                                        )
                                      ],
                                    ))
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Stack(
                              children: [
                                TextFormField(
                                    controller: controller.phoneNumber,
                                    keyboardType: TextInputType.number,
                                    decoration: InputDecoration(
                                      hintText: "signUp.phone".tr,
                                      prefixIcon:
                                      new Icon(Icons.phone, color: Colors.white),
                                      hintStyle: TextStyle(color: Color(0xff8d7249)),
                                    ),
                                    style: TextStyle(color: Colors.white)),
                                Positioned(
                                    right: 15,
                                    top: 0,
                                    bottom: 0,
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          "signUp.optional".tr,
                                          style: TextStyle(color: Color(0xff8d7249)),
                                        )
                                      ],
                                    ))
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            GestureDetector(
                              onTap: () =>
                                  controller.dateOfBirthModalBottomSheet(context),
                              child: Stack(
                                children: [
                                  Obx((){
                                    return TextFormField(
                                      enabled: false,
                                      keyboardType: TextInputType.number,
                                      decoration: InputDecoration(
                                        hintText:controller.userDate.value != null
                                            ? controller.userDate.value.toString()
                                            .toString()
                                            .substring(0, 10)
                                            : "textFiled.dateBirth".tr,
                                        prefixIcon: new Icon(Icons.date_range,
                                            color: Colors.white),
                                        hintStyle: TextStyle(color: Color(0xff8d7249)),
                                      ),
                                    );
                                  }),
                                  Positioned(
                                      right: 15,
                                      top: 0,
                                      bottom: 0,
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            "signUp.optional".tr,
                                            style: TextStyle(color: Color(0xff8d7249)),
                                          )
                                        ],
                                      ))
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            TextFormField(
                              controller: controller.quranParts,
                              validator: (text) {
                                if (text.isEmpty) {
                                  return "messages.addQuranParts".tr;
                                }
                                return null;
                              },
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                  hintText: "messages.quranParts".tr,
                                  prefixIcon: new Icon(Icons.list, color: Colors.white),
                                  hintStyle: TextStyle(color: Color(0xff8d7249))),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Visibility(visible: controller.isTeacher.value,child: Column(
                              children: [
                                TextFormField(
                                  controller: controller.availableTimes,
                                  validator: (text) {
                                    if (text.isEmpty) {
                                      return "messages.availableTimes".tr;
                                    }
                                    return null;
                                  },
                                  keyboardType: TextInputType.number,
                                  decoration: InputDecoration(
                                      hintText: "textFiled.availableTimes".tr,
                                      prefixIcon:
                                      new Icon(Icons.timer, color: Colors.white),
                                      hintStyle: TextStyle(color: Color(0xff8d7249))),
                                ),
                                SizedBox(
                                  height: 10,
                                )
                              ],
                            )),
                            Visibility(visible: controller.isTeacher.value,child: Column(
                              children: [
                                TextFormField(
                                  controller: controller.workingHours,
                                  validator: (text) {
                                    if (text.isEmpty) {
                                      return "messages.availableTimes".tr;
                                    }
                                    return null;
                                  },
                                  keyboardType: TextInputType.number,
                                  decoration: InputDecoration(
                                      hintText: "textFiled.workingHour".tr,
                                      prefixIcon: new Icon(Icons.hourglass_bottom,
                                          color: Colors.white),
                                      hintStyle: TextStyle(color: Color(0xff8d7249))),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                              ],
                            )),

                            Visibility(visible: controller.isTeacher.value,child: Column(
                              children: [
                                TextFormField(
                                  controller: controller.mastery_certificates,
                                  validator: (text) {
                                    if (text.isEmpty) {
                                      return "messages.addyourMatery".tr;
                                    }
                                    return null;
                                  },
                                  keyboardType: TextInputType.number,
                                  decoration: InputDecoration(
                                      hintText: "textFiled.Materycertification".tr,
                                      prefixIcon: new Icon(Icons.format_list_numbered,
                                          color: Colors.white),
                                      hintStyle: TextStyle(color: Color(0xff8d7249))),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                              ],
                            )),

                            Obx(() {
                              return Stack(
                                children: [
                                  TextFormField(
                                    obscureText: controller.showPassword.value,
                                    controller: controller.password,
                                    validator: (text) {
                                      if (text.isEmpty) {
                                        return "messages.addPassword".tr;
                                      }
                                      return null;
                                    },
                                    decoration: InputDecoration(
                                      hintText: "textFiled.password".tr,
                                      prefixIcon:
                                      new Icon(Icons.lock, color: Colors.white),
                                      hintStyle: TextStyle(color: Color(0xff8d7249)),
                                    ),
                                  ),
                                  Positioned(
                                      right: 15,
                                      top: 0,
                                      bottom: 0,
                                      child: IconButton(
                                          onPressed: () {
                                            if (controller.showPassword.value) {
                                              controller.showPassword.value = false;
                                            } else {
                                              controller.showPassword.value = true;
                                            }
                                          },
                                          icon: controller.showPassword.value
                                              ? Icon(
                                            Icons.visibility_rounded,
                                          )
                                              : Icon(
                                            Icons.visibility_off,
                                          )))
                                ],
                              );
                            }),
                            SizedBox(
                              height: 10,
                            ),
                            Obx(() {
                              return Stack(
                                children: [
                                  TextFormField(
                                    obscureText: controller.showConfirm.value,
                                    validator: (text) {
                                      if (text.isEmpty) {
                                        return "messages.addConfirmPassword".tr;
                                      }
                                      if (text != controller.password.text) {
                                        return "messages.passwordNotEquals".tr;
                                      }
                                      return null;
                                    },
                                    decoration: InputDecoration(
                                      hintText: "textFiled.confirmPassword".tr,
                                      prefixIcon: new Icon(Icons.lock_open_sharp,
                                          color: Colors.white),
                                      hintStyle: TextStyle(color: Color(0xff8d7249)),
                                    ),
                                  ),
                                  Positioned(
                                      right: 15,
                                      top: 0,
                                      bottom: 0,
                                      child: IconButton(
                                          onPressed: () {
                                            if (controller.showConfirm.value) {
                                              controller.showConfirm.value = false;
                                            } else {
                                              controller.showConfirm.value = true;
                                            }
                                          },
                                          icon: controller.showConfirm.value
                                              ? Icon(
                                            Icons.visibility_rounded,
                                          )
                                              : Icon(
                                            Icons.visibility_off,
                                          )))
                                ],
                              );
                            }),

                            SizedBox(
                              height: controller.isTeacher.value ? 20 : 40,
                            ),

                            Visibility(
                              visible: controller.isTeacher.value,
                              child: Column(
                                children: [
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Container(
                                        height: 22,
                                        width: 22,
                                        color: Color(0xff8d7249),
                                        padding: EdgeInsets.all(2),
                                        child: Container(
                                          height: 22,
                                          width: 22,
                                          color: controller.mogazah.value
                                              ? Color(0xff8d7249)
                                              : Colors.white,
                                          child: Obx((){
                                            return Checkbox(
                                              value: controller.mogazah.value,
                                              onChanged: (value) {
                                                controller.mogazah.value = value;
                                              },
                                            );
                                          }),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Text(
                                        "signUp.MogazhOrNot".tr,
                                        style: TextStyle(
                                            fontSize: 17,
                                            color: Color(0xff8d7249),
                                            fontWeight: FontWeight.w400),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),

                          ],
                        ),
                      ),
                    ),
                  ),

                  Stack(
                    children: [
                      Align(alignment: Alignment.bottomCenter,
                          child: Image.asset('assets/images/register_bc.png')),
                      Container(
                        height: 60,
                        alignment: Alignment.center,
                        margin: EdgeInsets.only(top: 30),
                        child:OutlinedButton(
                          onPressed: () {

                            if(!controller.from.currentState.validate()){
                              return;
                            }

                            Get.toNamed(RecordVoiceScreen.routeName);
                          },
                          style: ButtonStyle(
                            minimumSize: MaterialStateProperty.all<Size>(
                                Size(Get.width * 90 / 100, 50)),
                            side: MaterialStateProperty.all<BorderSide>(
                                BorderSide(color: Color(0xff8d7249))),
                            shape:
                            MaterialStateProperty.all<OutlinedBorder>(
                                RoundedRectangleBorder(
                                  side: BorderSide(
                                      style: BorderStyle.solid,
                                      color: Color(0xff8d7249),
                                      width: 1), // <-- this doesn't work?
                                  borderRadius:
                                  BorderRadius.all(Radius.circular(5)),
                                )),
                            // foregroundColor: MaterialStateProperty.all<Color>(AppColors.SecondaryButtonText),
                            textStyle: MaterialStateProperty.all<TextStyle>(
                                TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                )),
                          ),
                          child: Text(
                            "signUp.Continue_For_Level_Test".tr,
                            style: TextStyle(
                                color: Color(0xff8d7249),
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      )
                    ],
                  )

                ],
              ),
            ),
            // CancelRecord()
          ],
        ),
      ),
    );
  }
}


class SS extends GetView<RecordVoiceController> {
  @override
  Widget build(BuildContext context) {
    return Obx((){
      if(controller.isRecording.value){
        return Container();
      }
      return Container();
    });
  }
}

