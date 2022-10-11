
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:manazel_alabrar/Login/Splash/SplashController.dart';


class SplashScreen extends GetView<SplashController> {

  static const String routeName = "SplashScreen";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx((){
        if(controller.start.value){}
        return Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Center(
              child: Container(
                height: 200,
                width: 200,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage('assets/images/c_logo.png'))),
              ),
            ),
            Stack(
              alignment: Alignment.center,
              children: [
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Image.asset(
                    'assets/images/bottom_img.png',
                    color: Color(0xff8d7249),
                    fit: BoxFit.fitHeight,
                  ),
                ),
                Positioned(bottom: 10, child: Center(child: CircularProgressIndicator()))
              ],
            )
          ],
        );
      }),
    );
  }
}

