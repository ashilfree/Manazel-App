

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';


bool get isPortal {
  return Get.mediaQuery.orientation == Orientation.portrait;
}


double textSize(double s){
  return isPortal ? Get.width * s / 100 : Get.height * s / 100;
}

closeKeyboard(BuildContext context){
  FocusScopeNode currentFocus = FocusScope.of(context);
  if (!currentFocus.hasPrimaryFocus) {
    currentFocus.focusedChild.unfocus();
  }
}