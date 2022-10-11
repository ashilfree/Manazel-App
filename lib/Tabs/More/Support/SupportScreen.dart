import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:manazel_alabrar/Helper/Loading.dart';
import 'package:manazel_alabrar/Tabs/More/Support/SupportController.dart';
import 'package:sizer/sizer.dart';



class SupportScreen extends GetView<SupportController> {
  static const String routeName = "SupportScreen";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("contactUs.Support".tr),
      ),
      body: Padding(
        padding: EdgeInsets.only(top: 20, right: 15, left: 15),
        child: SingleChildScrollView(
          child: Center(
            child: Form(
              key: controller.form,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/images/c_logo.png',
                    height: 120,
                    width: 120,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    validator: (text){
                      if(text.isEmpty){
                        return "messages.must_not_empty".tr;
                      }
                      return null;
                    },
                    controller: controller.name,
                    decoration: InputDecoration(
                        hintText: "contactUs.name".tr, hintStyle: TextStyle(fontSize: 12.sp)),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  TextFormField(
                    validator: (text){
                      if(text.isEmpty){
                           return "messages.must_not_empty".tr;
                      }
                      return null;
                    },
                    controller: controller.phone_number,
                    decoration: InputDecoration(
                        hintText: "contactUs.phone".tr,
                        hintStyle: TextStyle(fontSize: 12.sp)),
                  ),
                  SizedBox(
                    height: 35,
                  ),
                  TextFormField(
                    validator: (text){
                      if(text.isEmpty){
                            return "messages.must_not_empty".tr;
                      }
                      return null;
                    },
                    controller: controller.message,
                    maxLines: 7,
                    decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(width: 1, color: Colors.grey)),
                        hintText: "contactUs.Write_your_problem".tr,
                        hintStyle: TextStyle(fontSize: 12.sp)),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    height: 50,
                    width: Get.width,
                    child: Obx((){

                      if(controller.loading.value){
                        return LoadingPage();
                      }

                      return ElevatedButton(
                        child: Text("recordVoice.send".tr,textAlign: TextAlign.center,style: TextStyle(
                            fontSize: 13.sp,
                            color: Colors.white,
                            fontWeight: FontWeight.bold),),
                        onPressed: () {
                          if(!controller.form.currentState.validate()){
                            return;
                          }
                          controller.send();
                        },
                      );
                    }),
                  ),

                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
