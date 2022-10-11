import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';
import 'package:manazel_alabrar/Helper/Loading.dart';
import 'package:manazel_alabrar/Tabs/More/About/AboutUsController.dart';



class AboutUsScreen extends GetView<AboutUsController> {
  static const String routeName = "AboutUsScreen";
  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(
        title: Text("aboutUs.appBar".tr),
      ),
      body: NestedScrollView(
          physics: ClampingScrollPhysics(),
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              SliverList(
                delegate: SliverChildListDelegate([
                  Obx((){
                    if(controller.loading.value){
                      return Container();
                    }
                    return Container(
                      width: double.infinity,
                      child: Image.network(controller.aboutUs.value.name),
                    );
                  })
                ]),
              ),
            ];
          },
          body:Obx((){

            if(controller.loading.value){
              return LoadingPage();
            }
            
            if(controller.loading.value){
              return LoadingPage();
            }
            
            return Padding(
              padding: EdgeInsets.all(14.0),
              child: SingleChildScrollView(
                child: Html(
                  data:controller.aboutUs.value.getName(),
                  onLinkTap: (url) {},
                ),
              ),
            );
            
          })
      ),
    );
    
  }
}
