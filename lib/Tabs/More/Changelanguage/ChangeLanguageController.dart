

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:manazel_alabrar/Helper/Language.dart';
import 'package:manazel_alabrar/Helper/Storage.dart';

class ChangeLanguageController extends GetxController{

  RxBool isArabic = false.obs;
  Rx<Language> languageSelected = Rx<Language>(null);



  changeLanguage(Language la){
    languageSelected.value = la;
    switch(Get.locale.languageCode){
      case "ar":
        Get.updateLocale(Locale('en', 'US'));
        Storage.saveLocale("en");
        isArabic.value = false;
        break;
      case "en":
        Get.updateLocale(Locale('ar', 'AE'));
        Storage.saveLocale("ar");
        isArabic.value = true;
        break;
    }
  }



  bool isCountryLanguage(Language language) {
    if(this.languageSelected.value==null){
      return false;
    }
    return this.languageSelected.value.id == language.id;
  }



  @override
  void onReady() {
    isArabic.value = Get.locale.languageCode == "en";
    languageSelected.value = Language.getLanguage();
    super.onReady();
  }


}