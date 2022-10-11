


import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

error(String message){
  Get.snackbar(message,"",backgroundColor: Colors.red,colorText: Colors.white,margin: EdgeInsets.symmetric(horizontal: 15,vertical: 25));
}

success(String message){
  Get.snackbar(message,"",backgroundColor: Colors.green,colorText: Colors.white,margin: EdgeInsets.symmetric(horizontal: 15,vertical: 25));
}


