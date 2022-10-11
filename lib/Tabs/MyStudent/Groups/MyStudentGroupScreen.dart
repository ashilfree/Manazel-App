import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:manazel_alabrar/Helper/CustomAlertDialog.dart';
import 'package:manazel_alabrar/Helper/Loading.dart';
import 'package:manazel_alabrar/Tabs/MyStudent/Groups/MyStudentGroupController.dart';
import 'package:manazel_alabrar/Tabs/MyStudent/Students/MyStudentScreen.dart';
import 'package:manazel_alabrar/model/Group.dart';
import 'package:sizer/sizer.dart';





class MyStudentGroupScreen extends StatefulWidget {
  @override
  _MyStudentGroupScreenState createState() => _MyStudentGroupScreenState();
}

class _MyStudentGroupScreenState extends State<MyStudentGroupScreen> {
  var c = Get.lazyPut(()=>MyStudentGroupController());
  @override
  Widget build(BuildContext context) {
    return _MyStudentGroupScreen();
  }
}

class _MyStudentGroupScreen extends GetView<MyStudentGroupController> {

  @override
  Widget build(BuildContext context) {
    Get.put(()=>MyStudentGroupController());
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Obx((){
        if(controller.loading.value){
          return LoadingPage();
        }
        return GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
              crossAxisCount: 3,
              childAspectRatio: 0.8),
          itemCount: controller.listGroups.length,
          itemBuilder: (context, index) {
            Group group = controller.listGroups[index];
            return InkWell(
              onTap: () {
                controller.groupSelected = group;

                if(controller.groupSelected.isBanned){
                  customAlertBox(Get.context,"messages.bannedGroup".tr);
                  return;
                }

                Get.toNamed(MyStudentScreen.routeName);
              },
              child: Container(
                alignment: Alignment.center,
                padding: EdgeInsets.all(5),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Color(0xff8d7249), width: 2)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/images/group_icon.png',
                      height: 60,
                      width: 60,
                    ),
                    Divider(
                      color: Color(0xff8d7249),
                      thickness: 1.25,
                    ),
                    Text(group.getName(),
                        style: TextStyle(
                            color: Color(0xff9d7249),
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w400))
                  ],
                ),
              ),
            );
          },
        );
      }),
    );
  }
}





