import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:manazel_alabrar/Helper/Loading.dart';
import 'package:manazel_alabrar/Helper/VideoCustom.dart';
import 'package:manazel_alabrar/Tabs/More/AppGuideliens/AppGuidelinesController.dart';
import 'package:manazel_alabrar/main.dart';
import 'package:manazel_alabrar/model/AppGuidLine.dart';
import 'package:sizer/sizer.dart';





class AppGuidelinesScreen extends GetView<AppGuidelinesController> {
  static const String routeName = "AppGuidelinesScreen";
  const AppGuidelinesScreen({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Obx((){
          if(controller.loading.value){
            return LoadingPage();
          }
          return Column(
            children: [

              Container(
                margin: EdgeInsets.only(top: 50,right: 30,left: 30),
                alignment: Alignment.bottomRight,
                child: InkWell(
                  onTap: () async{
                    Get.back();
                  },
                  child: Text(
                    "guid.appBar".tr,
                    style: TextStyle(
                        color: Color(0xff8d7249),
                        fontSize: 15.sp,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),

              Expanded(child: CarouselSlider(
                items: controller.appGuidLine.map((e) {
                  return Screen1Guideline(appGuidLine: e,controller: controller,);
                }).toList(),
                carouselController: controller.carouselController,
                options: CarouselOptions(
                  autoPlay: false,
                  height: Get.height,
                  viewportFraction: 1.0,
                  onPageChanged: (index,c){
                    controller.current.value = index;
                  }
                ),
              )),

              Obx((){
                return Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: controller.appGuidLine.map((url) {
                    int index = controller.appGuidLine.indexOf(url);
                    return Container(
                      width: 8.0,
                      height: 8.0,
                      margin: EdgeInsets.symmetric(vertical: 4.0, horizontal: 2.0),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: controller.current.value == index ? Color(0xff8d7249) : Colors.grey,
                      ),
                    );
                  }).toList(),
                );
              }),

              SizedBox(height: 60,)

            ],
          );
        }));
  }
}




class Screen1Guideline extends StatelessWidget {
  final AppGuidLine appGuidLine;
  final AppGuidelinesController controller;
  const Screen1Guideline({Key key, this.appGuidLine, this.controller}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.only(top: 50.0, bottom: 20, right: 10, left: 10),
        child: Column(
          children: [


            Expanded(flex: 3,child: appGuidLine.image == null ?  Container(
              height: 300,
              child: Text("image == null"),
            ) : appGuidLine.image.contains("base64") ? imageFromBase64String(appGuidLine.image) :  appGuidLine.type == "video" ?
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.0),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20.0),
                child: VideoCustom(
                  url: appGuidLine.image,
                ),
              ),
            ) :
            CircleAvatar(
                maxRadius: 120,
                backgroundImage: NetworkImage(appGuidLine.image))),

           Expanded(child: Column(
             children: [
               Text(
                 appGuidLine.getTitle(),
                 style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
               ),
               SizedBox(
                 height: 15,
               ),
               Text(
                 appGuidLine.getDes(),
                 style: TextStyle(
                     fontSize: 17,
                     fontWeight: FontWeight.bold,
                     color: Colors.grey),
               ),

             ],
           ))
          ],
        ),
      ),
    );
  }
}


