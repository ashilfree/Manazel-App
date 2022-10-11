

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:manazel_alabrar/Api/Api.dart';
import 'package:manazel_alabrar/model/AyaTest.dart';
import 'package:sizer/sizer.dart';


class SignUpController extends GetxController{

  var from = GlobalKey<FormState>();
  RxBool mogazah = false.obs;
  Rx<DateTime> userDate = Rx<DateTime>(null);
  // DateTime finalDOB = null;

  RxBool showConfirm = true.obs;
  RxBool showPassword = true.obs;


  TextEditingController username = TextEditingController();
  TextEditingController password = TextEditingController();

  TextEditingController quranParts = TextEditingController();
  TextEditingController availableTimes = TextEditingController();
  TextEditingController workingHours = TextEditingController();
  TextEditingController mastery_certificates = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController phoneNumber = TextEditingController();
  TextEditingController bDate = TextEditingController();



  RxBool isTeacher = false.obs;




  dateOfBirthModalBottomSheet(context) {
    showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (BuildContext context) {
          return Container(
            height: MediaQuery.of(context).copyWith().size.height *50 / 100,
            child: Column(
              children: [

                OutlinedButton(
                  onPressed: () {
                    Get.back();
                  },
                  child:Text(
                    "Done",
                    style: TextStyle(
                        fontSize: 13.sp,
                        fontWeight: FontWeight.bold),
                  ),
                ),


                Expanded(child: CupertinoDatePicker(
                  mode: CupertinoDatePickerMode.date,
                  initialDateTime: DateTime.now(),
                  maximumYear: 2021,
                  maximumDate: DateTime.now(),
                  minimumDate: DateTime(1921, 1, 1),
                  onDateTimeChanged: (DateTime newDateTime) {
                    print(newDateTime.toString());
                    userDate.value = newDateTime;
                    bDate.text = userDate.value.toString().substring(0, 10);
                  },
                ))
              ],
            ),
          );
        });
  }



  RxBool loadingText = false.obs;
  Rx<AyaTest> ayaTest = Rx<AyaTest>(null);

  getTestMp3()async{
    loadingText.value = true;
    try{
      dynamic json = await Api().get(Url.url+Url.ayah_test,queryParams: {"lang":Get.locale.languageCode},withAuthorization: false);
      ayaTest.value = AyaTest.fromJson(json);
      loadingText.value  = false;
    } catch(err){
      print("err : " + err.toString());
      loadingText.value  = false;
    }
  }

  @override
  void onInit() {
    getTestMp3();
    super.onInit();
  }


}