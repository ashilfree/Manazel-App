import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';
import 'package:manazel_alabrar/Helper/Loading.dart';
import 'package:manazel_alabrar/Tabs/More/Terms/TermsController.dart';

class Terms extends GetView<TermsController> {
  static const String routeName = "Terms";
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text("terms.Terms_And_Conditions".tr),
      ),
      body: Obx((){


        if(controller.loading.value){
          return LoadingPage();
        }
        return Padding(
          padding: EdgeInsets.all(14.0),
          child: SingleChildScrollView(
            child: Html(
              data:controller.aboutUs.value.getName(),
              onLinkTap: (url) {

              },
            ),
          ),
        );
      }),
    );
  }
}
