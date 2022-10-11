
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:manazel_alabrar/Helper/Screen.dart';
import 'package:manazel_alabrar/Login/RecordVoice/widget/DialogHearAya.dart';
import 'package:manazel_alabrar/Login/RecordVoice/widget/DialogRecordVoic.dart';
import 'package:manazel_alabrar/Login/RecordVoice/Controller/RecordVoiceController.dart';
import 'package:sizer/sizer.dart';


class RecordVoiceScreen extends GetView<RecordVoiceController> {

  static const String routeName = "RecordVoiceScreen";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: isPortal ? Get.height : Get.width,
        child: Column(
          children: [

            SizedBox(height: 40,),

            Container(
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(child: Container(
                    alignment: Alignment.centerLeft,
                    child: IconButton(onPressed: (){
                      Get.back();
                    }, icon: Icon(Icons.arrow_back,size: 15.sp,)),
                  )),
                  Expanded(child: Image.asset(
                    "assets/images/c_logo.png",
                    height: 120,
                    width: 120,
                  )),
                  Expanded(child: Container(width: 30,)),
                ],
              ),
            ),



            Expanded(child: Container(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [

                  Column(
                    children: [

                      Container(
                        width: Get.width,
                        child: OutlinedButton.icon(
                          icon: Expanded(child: Container(
                            alignment: Alignment.centerLeft,
                            child: Container(
                              decoration: BoxDecoration(
                                  border: Border.all(color: Get.theme.primaryColor,width: 1.5),
                                  borderRadius: BorderRadius.all(Radius.circular(10))
                              ),
                              padding: EdgeInsets.all(4),
                              child: Icon(Icons.play_arrow_outlined,size: 15.sp,),
                            ),
                          )),
                          onPressed: () {
                            Get.dialog(DialogHearAya(controller: controller,));
                          },
                          label: Expanded(
                            flex: 3,
                            child: Container(
                              alignment: Alignment.centerRight,
                              child: Text("recordVoice.hear".tr,style: TextStyle(fontSize: 12.sp),),
                            ),
                          ),
                        ),
                      ),

                      SizedBox(height: 30,),

                      Column(
                        children: [
                          Container(
                            width: Get.width,
                            child: OutlinedButton.icon(
                              icon: Expanded(child: Container(
                                alignment: Alignment.centerLeft,
                                child: Container(
                                  decoration: BoxDecoration(
                                      border: Border.all(color: Get.theme.primaryColor,width: 1.5),
                                      borderRadius: BorderRadius.all(Radius.circular(10))
                                  ),
                                  padding: EdgeInsets.all(4),
                                  child: Icon(Icons.mic,size: 15.sp,),
                                ),
                              )),
                              onPressed: () {
                                Get.dialog(DialogRecordVoice(controller: controller,));
                              },
                              label: Expanded(
                                flex: 3,
                                child: Container(
                                  alignment: Alignment.centerRight,
                                  child: Text("recordVoice.record".tr,style: TextStyle(fontSize: 12.sp),),
                                ),
                              ),
                            ),
                          ),
                          Divider(thickness: 1,)
                        ],
                      ),

                    ],
                  ),

                  Container(
                    width: Get.width * 80 / 100,
                    child:Obx(() {
                      return AnimatedSwitcher(
                        duration: Duration(milliseconds: 300),
                        child:controller.loading.value
                            ? CircularProgressIndicator()
                            :  OutlinedButton(
                          onPressed: () {
                            controller.signUp();
                          },
                          style: ButtonStyle(
                            side: MaterialStateProperty.all<BorderSide>(
                                BorderSide(color: Get.theme.primaryColor)),
                          ),
                          child:Text(
                            "recordVoice.send".tr,
                            style: TextStyle(
                                fontSize: 13.sp,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      );
                    }),
                  )

                ],
              ),
            ))

          ],
        ),
      ),
    );
  }

}



class CancelRecord extends GetView<RecordVoiceController> {
  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 30,right: 0,left: 0,
      child: Obx((){
        return Visibility(
          visible: controller.isRecording.value,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              DragTarget<Widget>(
                onWillAccept: (w){
                  // controller.stop();
                  print("onWillAccept" + w.toString());
                  return w is Widget;
                },
                onAccept: (data){
                  print("onAccept ---------  ");
                },
                onLeave: (data){
                  print("onLeave  " +  data.toString());
                  // controller.delete();
                },

                builder: (c,w,r){
                  print("ss");
                  return Icon(Icons.delete,color: Colors.red,size: 80,);
                },
              )
            ],
          ),
        );
      }),
    );
  }
}
