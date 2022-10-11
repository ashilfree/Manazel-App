import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:manazel_alabrar/Login/Forget/ForgetPasswordController.dart';


class ForgetPasswordScreen extends GetView<ForgetPasswordController> {
  static const String routeName = "ForgetPasswordScreen";
  const ForgetPasswordScreen({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
              top: 50,
              left: 20,
              child: InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Icon(
                  Icons.clear,
                  size: 30,
                  color: Color(0xff8d7249),
                ),
              )),
          Padding(
            padding: const EdgeInsets.only(left: 20.0, right: 20, top: 70),
            child: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Image.asset(
                    'assets/images/c_logo.png',
                    height: 120,
                    width: 120,
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  TextField(
                    decoration: InputDecoration(
                        hintText: "Enter your email",
                        hintStyle: TextStyle(color: Color(0xff8d7249))),
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  Container(
                    height: 45,
                    alignment: Alignment.center,
                    width: MediaQuery.of(context).size.width * 0.7,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(2),
                        color: Color(0xff8d7249)),
                    child: Text(
                      "Send",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 22,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(children: [
                        TextSpan(
                          text:
                          "you will recieve an email to reset your password if you didn't recieve it ",
                          style:
                          TextStyle(fontSize: 17, color: Colors.grey[800]),
                        ),
                        TextSpan(
                            text: "re-send",
                            style: TextStyle(
                                fontSize: 17,
                                color: Color(0xff8d7249),
                                fontWeight: FontWeight.bold))
                      ])),
                ],
              ),
            ),
          ),
          Align(
              alignment: Alignment.bottomCenter,
              child: Image.asset('assets/images/register_bc.png'))
        ],
      ),
    );
  }
}

