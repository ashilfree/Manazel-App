import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:manazel_alabrar/Chat/Controller/ChatController.dart';
import 'package:manazel_alabrar/Chat/widget/ItemMessage.dart';
import 'package:manazel_alabrar/Chat/widget/editTextMessage.dart';
import 'package:manazel_alabrar/Helper/CustomTextGrey.dart';
import 'package:manazel_alabrar/Helper/EmptyWidget.dart';
import 'package:manazel_alabrar/Helper/Loading.dart';
import 'package:manazel_alabrar/model/MessageData.dart';
import 'package:manazel_alabrar/model/Student.dart';
import 'package:manazel_alabrar/model/User.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:sizer/sizer.dart';






class ChatScreen extends GetView<ChatController> {
  static const String routeName = "ChatScreen";
  const ChatScreen({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {


    return Directionality(
      textDirection: TextDirection.ltr,
      child: Scaffold(
        appBar: AppBar(
          title: Text(Get.arguments["name"].toString()),
          actions: [

            context.read<User>().isTeacher ? InkWell(
              onTap: () {

              },
              child: PopupMenuButton<String>(
                onSelected: (value) {

                  switch(value){

                    case "1":
                      controller.addStatus("read");
                      break;

                    case "2":
                      controller.addStatus("not read");
                      break;

                    case "3":
                      controller.addStatus("trmim");
                      break;

                    case "4":
                      controller.addStatus("stopped");
                      break;

                  }
                },
                padding: EdgeInsets.all(1),
                iconSize: 30.sp,
                itemBuilder: (BuildContext context) =>
                <PopupMenuEntry<String>>[
                  PopupMenuItem<String>(
                    value: "1",
                    child: Text("chat.dropDown1".tr,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontFamily: 'Cairo',
                            fontWeight: FontWeight.w300,
                            fontSize:20
                        )
                    ),
                  ),
                  PopupMenuItem<String>(
                    value:"2",
                    child: Text("chat.dropDown2".tr,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontFamily: 'Cairo',
                            fontWeight: FontWeight.w300,
                            fontSize: 20)),
                  ),
                  PopupMenuItem<String>(
                    value: "3",
                    child: Text("chat.dropDown3".tr,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontFamily: 'Cairo',
                            fontWeight: FontWeight.w300,
                            fontSize: 20)),
                  ),
                  PopupMenuItem<String>(
                    value: '4',
                    child: Text("chat.dropDown4".tr,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontFamily: 'Cairo',
                            fontWeight: FontWeight.w300,
                            fontSize: 20)),
                  ),
                ],
              ),
            ) : Container(),

          ],
        ),
        body: SafeArea(
          child: Column(
            children: [
              Expanded(
                child: Obx((){
                  return SmartRefresher(
                      enablePullDown: false,
                      enablePullUp: controller.list.isNotEmpty && controller.enablePullUp.value,
                      reverse: true,
                      header: WaterDropHeader(
                        waterDropColor: Colors.red,
                      ),
                      footer: CustomFooter(
                        height: 250,
                        builder: (BuildContext context,LoadStatus mode){
                          Widget body;

                          if(mode==LoadStatus.idle){
                                    body = Container();
                          }
                          else if(mode==LoadStatus.loading){
                            body =  CircularProgressIndicator(strokeWidth: 2,);
                          }
                          else if(mode == LoadStatus.failed){
                            body = Container();
                          }
                          else if(mode == LoadStatus.canLoading){
                            body = Container();
                          }
                          else{
                            body = CustomTextGrey("chat.noMoreMessage".tr,size: 12.sp,);
                          }
                          return Container(
                            height: 55.0,
                            child: Center(child:body),
                          );
                        },
                      ),
                      controller: controller.refreshController,
                      onRefresh: controller.onRefresh,
                      onLoading: controller.onLoadingRefresh,
                      child:


                      //  ------------- if
                      controller.loadingList.value ? LoadingPage()


                          :


                      //  ------------- else
                      //  ------------- if
                      !controller.loadingList.value && controller.list.isEmpty ?

                      EmptyWidget(
                        iconSize: 50.sp,
                        textSize: 15.sp,
                        icon: Icons.messenger_outline,
                        title: "chat.empty".tr,
                      )

                          :

                      //  ------------- else
                      ListView.builder(
                        itemCount:controller.list.length,
                        reverse: true,
                        padding: EdgeInsets.only(bottom: 5, top: 10),
                        itemBuilder: (context, index) {
                          MessageData messageData = controller.list[index];
                          return ItemMessage(
                            messageData: messageData,
                            controller: controller,
                          );
                        },
                      )


                  );
                }),
              ),

              SizedBox(height: 10,),

              EditTextMessage(),

            ],
          ),
        ),
      ),
    );
  }
}

