import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:manazel_alabrar/Chat/ChatScreen.dart';
import 'package:manazel_alabrar/Helper/EmptyList.dart';
import 'package:manazel_alabrar/Helper/Loading.dart';
import 'package:manazel_alabrar/Login/SignIn/SignIn.dart';
import 'package:manazel_alabrar/Tabs/MyTeacher/MyTeacherController.dart';
import 'package:manazel_alabrar/model/Student.dart';
import 'package:manazel_alabrar/model/User.dart';
import 'package:provider/provider.dart';



class MyTeacherScreen extends StatefulWidget {
  static const String routeName = "MyTeacherScreenAfterLogin";
  @override
  _MyTeacherScreenState createState() => _MyTeacherScreenState();
}

class _MyTeacherScreenState extends State<MyTeacherScreen> {
  var controller = Get.put(MyTeacherController());
  @override
  Widget build(BuildContext context) {
    return _MyTeacherScreen();
  }
}


class _MyTeacherScreen extends GetView<MyTeacherController> {

  const _MyTeacherScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Consumer<User>(builder: (context,user,w){

      if(user.isNull){
        return SignIn();
      }

      return Obx((){

        if(controller.loading.value){
          return LoadingPage();
        }

        if(controller.teacher == null){
          return EmptyList(
            text: "myTeacher.empty".tr,
            icon: Icons.person,
          );
        }

        return Scaffold(
          body: Padding(
            padding: EdgeInsets.all(20),
            child: Material(
                elevation: 10,
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.35,
                  width: double.infinity,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [

                      Image.asset(
                        'assets/images/c_logo.png',
                        height: 100,
                        width: 100,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        controller.teacher.getName(),
                        style: TextStyle(
                          color: Color(0xff8d7249),
                          fontSize: 22,
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        "${"myTeacher.group".tr} : ${controller.teacher.teacherName}",
                        style: TextStyle(
                          color: Color(0xff8d7249),
                          fontSize: 22,
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      InkWell(
                        onTap: () {
                          Get.toNamed(ChatScreen.routeName,arguments: {"student":Student(id:user.id,username:user.username),"name":controller.teacher.teacherName});
                        },
                        child: Container(
                          height: 40,
                          width: 180,
                          color: Color(0xff8d7249),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.chat, color: Colors.white),
                              Text("myTeacher.openChat".tr,
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 17,))
                            ],
                          )
                        ),
                      )
                    ],
                  ),
                )),
          ),
        );
      });
    },);


  }
}


