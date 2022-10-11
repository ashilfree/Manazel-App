import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:manazel_alabrar/Tabs/MyAccount/EditProfile/EditProfileController.dart';
import 'package:manazel_alabrar/model/User.dart';
import 'package:sizer/sizer.dart';
import 'package:provider/provider.dart';


class EditMyProfile extends GetView<EditProfileController> {

  static const String routeName = "EditMyProfileScreenStudent";
  const EditMyProfile({Key key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("myAccount.editMyProfile".tr),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Center(
            child: Column(
              children: [
                Image.asset(
                  'assets/images/c_logo.png',
                  height: 120,
                  width: 120,
                ),
                SizedBox(
                  height: 20,
                ),
                Material(
                  elevation: 10,
                  child: Container(
                    padding: EdgeInsets.all(10),
                    child: Form(
                      key: controller.from,
                      child: Column(
                        children: [
                          TextFormField(
                            controller: controller.email,
                            keyboardType: TextInputType.emailAddress,
                            validator: (email){
                              if (email.isEmpty) {
                                return "messages.addYourEmail".tr;
                              }
                              if(email.isNotEmpty){
                                if(!email.isEmail){
                                  return "messages.checkEmail".tr;
                                }
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                              hintText: "textFiled.email".tr,
                              prefixIcon: new Icon(Icons.email, color: Colors.white),
                              hintStyle: TextStyle(color: Color(0xff8d7249)),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          TextFormField(
                              controller: controller.phoneNumber,
                              keyboardType: TextInputType.number,
                              validator: (text) {
                                if (text.isEmpty) {
                                  return "messages.addPhone".tr;
                                }
                                return null;
                              },
                              decoration: InputDecoration(
                                hintText: "textFiled.phone".tr,
                                prefixIcon:
                                new Icon(Icons.phone, color: Colors.white),
                                hintStyle: TextStyle(color: Color(0xff8d7249)),
                              ),
                              style: TextStyle(color: Colors.white)),
                          SizedBox(
                            height: 10,
                          ),
                          GestureDetector(
                          onTap: () =>
                              controller.dateOfBirthModalBottomSheet(context),
                          child: Obx((){
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
                                hintText: "textFiled.hifthParts".tr,
                                prefixIcon: new Icon(Icons.list, color: Colors.white),
                                hintStyle: TextStyle(color: Color(0xff8d7249))),
                          ),

                          SizedBox(
                            height: 10,
                          ),
                          Visibility(visible: context.read<User>().isTeacher,child: Column(
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
                          Visibility(visible: context.read<User>().isTeacher,child: Column(
                            children: [
                              TextFormField(
                                controller: controller.workingHours,
                                validator: (text) {
                                  if (text.isEmpty) {
                                    return "messages.addWorkingHour".tr;
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

                          SizedBox(
                            height: 20,
                          ),

                          Obx((){
                            return AnimatedSwitcher(duration: Duration(milliseconds: 300),
                              child: controller.loadingEdit.value ? CircularProgressIndicator() : OutlinedButton(
                                onPressed: () {
                                  if(!controller.from.currentState.validate()){
                                    return;
                                  }
                                  controller.edit();
                                },
                                style: ButtonStyle(
                                  minimumSize: MaterialStateProperty.all<Size>(
                                      Size(Get.width * 90 / 100, 50)),
                                  side: MaterialStateProperty.all<BorderSide>(
                                      BorderSide(color: Color(0xff8d7249))),
                                  shape: MaterialStateProperty.all<OutlinedBorder>(
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
                                  "editProfile.workingHour".tr,
                                  style: TextStyle(
                                      color: Color(0xff8d7249),
                                      fontSize: 12.sp,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),);
                          }),


                        ],
                      ),
                    ),
                  ),
                ),




                SizedBox(
                  height: 20,
                ),















                Material(
                  elevation: 10,
                  child: Container(
                    padding: EdgeInsets.all(10),
                    child: Form(
                      key: controller.from2,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            "editProfile.changePassword".tr,
                            style: TextStyle(
                                fontSize: 26, fontWeight: FontWeight.w400),
                          ),
                          SizedBox(
                            height: 20,
                          ),
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
                            height: 20,
                          ),
                          Obx((){
                            return AnimatedSwitcher(duration: Duration(milliseconds: 300),
                              child: controller.loadingChangePass.value ? CircularProgressIndicator() : OutlinedButton(
                                onPressed: () {
                                  if(!controller.from2.currentState.validate()){
                                    return;
                                  }
                                  controller.updatePassword();
                                },
                                style: ButtonStyle(
                                  minimumSize: MaterialStateProperty.all<Size>(
                                      Size(Get.width * 90 / 100, 50)),
                                  side: MaterialStateProperty.all<BorderSide>(
                                      BorderSide(color: Color(0xff8d7249))),
                                  shape: MaterialStateProperty.all<OutlinedBorder>(
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
                                  "editProfile.change".tr,
                                  style: TextStyle(
                                      color: Color(0xff8d7249),
                                      fontSize: 12.sp,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),);
                          }),
                        ],
                      ),
                    ),
                  ),
                ),


                SizedBox(height: 60,),
              ],
            ),
          ),
        ),
      ),
    );
  }
}


