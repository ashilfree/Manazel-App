

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:manazel_alabrar/Api/Api.dart';
import 'package:manazel_alabrar/Api/Url.dart';
import 'package:manazel_alabrar/Helper/Messages.dart';
import 'package:manazel_alabrar/Login/SignUp/SignUpController.dart';
import 'package:manazel_alabrar/model/Result.dart';
import 'package:manazel_alabrar/model/User.dart';
import 'package:sizer/sizer.dart';
import 'package:provider/provider.dart';

class EditProfileController extends GetxController{

  var from = GlobalKey<FormState>();
  var from2 = GlobalKey<FormState>();
  Rx<DateTime> userDate = Rx<DateTime>(null);


  TextEditingController password = TextEditingController();
  TextEditingController passwordConfirm = TextEditingController();


  TextEditingController quranParts = TextEditingController();
  TextEditingController availableTimes = TextEditingController();
  TextEditingController workingHours = TextEditingController();
  TextEditingController mastery_certificates = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController phoneNumber = TextEditingController();
  TextEditingController bDate = TextEditingController();


  @override
  void onInit() {
    userDate.value = Get.context.read<User>().getUserDate();
    email.text = Get.context.read<User>().username;
    phoneNumber.text = Get.context.read<User>().phone;
    quranParts.text = Get.context.read<User>().quranParts.toString();
    workingHours.text = Get.context.read<User>().workHours;
    availableTimes.text = Get.context.read<User>().availableTimes;
    super.onInit();
  }



  RxBool loadingEdit = false.obs;
  RxBool loadingChangePass = false.obs;

  RxBool showConfirm = true.obs;
  RxBool showPassword = true.obs;


  edit()async{

    loadingEdit.value = true;

    try{
      var data = {
        "email":email.text,
        "phoneNumber":phoneNumber.text,
        "bDate":bDate.text,
        "type":Get.context.read<User>().userType.toString().split(".")[1],
        "quranParts":quranParts.text,
      };

      if(Get.context.read<User>().isTeacher){
        data.addAll(
          {
          "availableTimes":availableTimes.text,
          "workingHours":workingHours.text
          }
        );
      }

      data.forEach((key, value) {
        print(key.toString() + "  " + value.toString());
      });

      dynamic json = await Api().post(Url.url+Url.updateUser,data:data ,withAuthorization: true);

      ResultApi result = ResultApi.fromJson(json);

      if(result.state == 0){
        print("err : " + result.error);
        error(result.error);
        loadingEdit.value  = false;
        return;
      }

      loadingEdit.value  = false;
      success(result.message);

    } catch(err){
      print("err : " + err.toString());
      loadingEdit.value  = false;
    }
  }



  updatePassword()async{

    loadingChangePass.value = true;

    try{
      var data = {
        "password":password.text,
      };

      data.forEach((key, value) {
        print(key.toString() + "  " + value.toString());
      });

      dynamic json = await Api().post(Url.url+Url.update_password,data:data ,withAuthorization: true);

      ResultApi result = ResultApi.fromJson(json);

      if(result.state == 0){
        print("err : " + result.error);
        error(result.error);
        loadingChangePass.value  = false;
        return;
      }

      loadingChangePass.value  = false;
      success(result.message);

    } catch(err){
      print("err : " + err.toString());
      loadingChangePass.value  = false;
    }
  }







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
                    bDate.text = userDate.value.toString();
                  },
                ))
              ],
            ),
          );
        });
  }





}