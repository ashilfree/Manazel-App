import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:manazel_alabrar/Chat/ChatScreen.dart';
import 'package:manazel_alabrar/Helper/Loading.dart';
import 'package:manazel_alabrar/Tabs/MyStudent/Groups/MyStudentGroupScreen.dart';
import 'package:manazel_alabrar/Tabs/MyStudent/Students/MyStudentController.dart';
import 'package:manazel_alabrar/model/Student.dart';
import 'package:sizer/sizer.dart';



class MyStudentScreen extends GetView<MyStudentController> {
  static const String routeName = "MyStudentScreen";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("myStudents.appBar".tr),
        centerTitle: true,
        leading: Container(
            margin: EdgeInsets.all(7),
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("assets/images/quran_readers.png"),
                    fit: BoxFit.cover))),
        actions: [
          IconButton(onPressed: (){
            controller.moveNextWeek();
          }, icon: Icon(
            Icons.calendar_today,
            size: 35,
          )),
          SizedBox(
            width: 5,
          )
        ],
      ),

      body: Padding(
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
            itemCount: controller.listStudent.length,
            itemBuilder: (context, index) {
              Student student = controller.listStudent[index];
              return EachGroupMember(student: student,);
            },
          );
        }),
      ),
    );
  }
}

class EachGroupMember extends StatelessWidget {
  final Student student;
  const EachGroupMember({Key key, this.student}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Get.toNamed(ChatScreen.routeName,arguments: {"student":student,"name":student.username}),
      child: Container(
        child: Column(
          children: [
            Container(
                height: 100,
                alignment: Alignment.center,
                padding: EdgeInsets.all(5),
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: Color(0xff8d7249), width: 2)),
                child: Image.asset(
                  'assets/images/my_account_icon_active.png',
                )),
            SizedBox(
              height: 10,
            ),
            Text(
              student.username.toString(),
              style: TextStyle(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.bold,
                  color: Color(0xff8d7249)),
            )
          ],
        ),
      ),
    );
  }
}