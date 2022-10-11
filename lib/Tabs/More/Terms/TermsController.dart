

import 'package:get/get.dart';
import 'package:manazel_alabrar/Api/Api.dart';
import 'package:manazel_alabrar/model/TermsData.dart';

class TermsController extends GetxController{

  RxBool loading = true.obs;
  Rx<TermsData> aboutUs = Rx<TermsData>(TermsData());


  getTerms()async{
    loading.value = true;
    try{
      dynamic data = await Api().get(Url.url+Url.get_terms_and_conditions,queryParams: {"lang":Get.locale.languageCode},withAuthorization: false);
      aboutUs.value = new TermsData.fromJson(data["success"]);
      loading.value  = false;
    } catch(err){
      print("err : " + err.toString());
      loading.value  = false;
    }
  }

  @override
  void onInit() {
    getTerms();
    super.onInit();
  }

}