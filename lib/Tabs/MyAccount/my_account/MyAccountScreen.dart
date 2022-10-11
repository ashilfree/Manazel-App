import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:manazel_alabrar/BottomBar/MainController.dart';
import 'package:manazel_alabrar/Login/SignIn/SignIn.dart';
import 'package:manazel_alabrar/Tabs/MyAccount/my_account/MyAccountController.dart';
import 'package:manazel_alabrar/model/User.dart';
import 'package:provider/provider.dart';
import 'package:manazel_alabrar/Tabs/More/more_tab/MoreScreen.dart';
import 'package:manazel_alabrar/Tabs/MyAccount/EditProfile/EditMyProfile.dart';
import 'package:manazel_alabrar/Tabs/MyAccount/MyAssignments/MyAssignmentScreenStudent.dart';
import 'package:manazel_alabrar/Tabs/MyAccount/Notification/NotificationsScreenStudent.dart';




class MyAccountScreen extends GetView<MyAccountController> {

  static const String routeName = "MyAccountScreen";
  const MyAccountScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<User>(builder: (context,user,w){
      if(user.isNull){
        return SignIn();
      }
      return SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              SizedBox(
                height: 10,
              ),
              GestureDetector(
                onTap:(){
                  controller.getImage();
                },
                child: Obx((){


                  if(controller.loadingUploadImage.value){
                    return Container(
                      height: 100,
                      width: 100,
                      padding: EdgeInsets.all(5),
                      child: CircularProgressIndicator(),
                    );
                  }

                  if(controller.image.value!=null){
                    return Container(
                      height: 150,
                      width: 150,
                      padding: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: FileImage(controller.image.value)),
                          border: Border.all(color: Color(0xff8d7249), width: 2),
                          shape: BoxShape.circle),
                    );
                  }

                  if(context.read<User>().image!=null){
                    return Container(
                      height: 150,
                      width: 150,
                      padding: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: NetworkImage(context.read<User>().image)),
                          border: Border.all(color: Color(0xff8d7249), width: 2),
                          shape: BoxShape.circle),
                    );
                  }

                  return Container(
                    height: 150,
                    width: 150,
                    padding: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage('assets/images/my_photo.png')),
                        border: Border.all(color: Color(0xff8d7249), width: 2),
                        shape: BoxShape.circle),
                  );
                }),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                "myAccount.editPhoto".tr,
                style: TextStyle(color: Color(0xff8d7249), fontSize: 16),
              ),
              SizedBox(
                height: 40,
              ),

              MoreItems(
                text: "myAccount.editMyProfile".tr,
                image: "assets/images/edit_my_profile_icon.png",
                onTap: () {
                  Get.toNamed(EditMyProfile.routeName);
                },
              ),

              MoreItems(
                text: "myAccount.myAssignment".tr,
                image: "assets/images/assignment_icon.png",
                onTap: () {
                  Get.toNamed(MyAssignmentScreenStudent.routeName);
                },
              ),

              MoreItems(
                text: "myAccount.myTeacher".tr,
                image: "assets/images/my_account_icon_active.png",
                onTap: () {
                  Get.find<MainController>().changePage(1);
                  // Get.toNamed(MyTeacherScreenAfterLogin.routeName);
                },
              ),

              MoreItems(
                text: "myAccount.notifications".tr,
                image: "assets/images/notification_icon.png",
                onTap: () {
                  Get.toNamed(NotificationsScreenStudent.routeName);
                },
              ),


              LevelItem(),


              SizedBox(height: 60,),

            ],
          ),
        ),
      );
    },);
  }

}

class LevelItem extends GetView<MyAccountController> {
  @override
  Widget build(BuildContext context) {


    return Column(
      children: [

        MoreItems(
          text: "myAccount.myLevel".tr,
          image: "assets/images/level_icon.png",
          onTap: () {
            controller.getLevel();
          },
        ),

        Builder(
          builder: (_){

            if(controller.myLevel.value == null){
              return Container();
            }

            if(controller.myLevel.value.subLevel == null && !context.read<User>().isTeacher){
              return MoreItems(
                text: "myAccount.SelectLevel".tr,
                image: "assets/images/level_icon.png",
                onTap: () {
                  controller.getSubLevels();
                },
                showDivider: false,
              );
            }

            return Container();
          },
        ),

      ],
    );
  }
}

