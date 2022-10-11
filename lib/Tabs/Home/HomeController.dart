
import 'package:get/get.dart';
import 'package:manazel_alabrar/Api/Api.dart';
import 'package:manazel_alabrar/Api/Url.dart';
import 'package:manazel_alabrar/Helper/VideoCustom.dart';
import 'package:manazel_alabrar/model/Home.dart';
import 'package:manazel_alabrar/model/User.dart';
import 'package:provider/provider.dart';



class HomeController extends GetxController{


  Rx<Home> home = Rx<Home>(null);
  RxBool loading = true.obs;
  VideoCustom videoCustom;
  // https://www.sample-videos.com/video123/mp4/720/big_buck_bunny_720p_20mb.mp4


  getHome()async{
    loading.value = true;
    try{
      dynamic data = await Api().get(Url.url+Url.get_reads,queryParams: {"lang":Get.locale.languageCode},withAuthorization: !Get.context.read<User>().isNull);
      print(data);
      home.value = new Home.fromJson(data);
      loading.value  = false;
    } catch(err){
      print("err : " + err.toString());
      loading.value  = false;
    }
  }

  @override
  void onInit() {
    getHome();
    super.onInit();
  }


}