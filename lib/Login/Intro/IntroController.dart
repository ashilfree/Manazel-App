

import 'dart:io';

import 'package:get/get.dart';
import 'package:manazel_alabrar/Api/Api.dart';
import 'package:manazel_alabrar/Helper/Storage.dart';
import 'package:manazel_alabrar/model/Country.dart';



class IntroController extends GetxController{


  RxBool loadingCountry = false.obs;
  RxList<Country> listCountry = RxList<Country>([]);
  Rx<Country> countrySelected = Rx<Country>(null);


  getCountry()async{
    loadingCountry.value = true;
    try{
      dynamic list = await Api().get(Url.url+Url.country,queryParams: {"lang":Get.locale.languageCode},withAuthorization: false);
      for(dynamic json in list){
        listCountry.add(Country.fromJson(json));
        print(json.toString());
      }
      loadingCountry.value  = false;
    } catch(err){
      print("err : " + err.toString());
      loadingCountry.value  = false;
    }
  }

  @override
  void onInit() {
    getCountry();
    setDeviceToApi();
    super.onInit();
  }


  void setDeviceToApi() async{
    if(!await Storage.deviceRegistered()){
       try{
         var result = await Api().post(Url.url+Url.platform_data,data: {"platform":Platform.isAndroid ? "android" : "ios"},queryParams: {"lang":Get.locale.languageCode});
         Storage.registerDevice();
         print(result.toString() + "   " + {"platform":Platform.isAndroid ? "android" : "ios"}.toString());
       }catch(err){
         print("err platform_data :  " + err.toString());
       }
    }
  }


  void selectCountry(Country country) async{
    countrySelected.value = country;
    await Storage.saveCountry(country);
  }

  bool isCountrySelected(Country country) {
    if(this.countrySelected.value==null){
      return false;
    }
    return this.countrySelected.value.id == country.id;
  }


}