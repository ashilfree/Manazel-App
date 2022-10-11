
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:get/get.dart';


class MyAssignmentWebView extends StatelessWidget {
  static const String routeName = "MyAssignmentWebView";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("myAssignment.appBar".tr),
      ),
      body: InAppWebView(
        initialUrl: Get.arguments,
        initialHeaders: {},
        initialOptions: InAppWebViewGroupOptions(
          crossPlatform: InAppWebViewOptions(
              debuggingEnabled: true,
              userAgent: "Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:61.0) Gecko/20100101 Firefox/61.0"
          ),
        ),
        onWebViewCreated: (InAppWebViewController controller) {
          // webView = controller;
          // print("onWebViewCreated");
        },
        onLoadStart: (InAppWebViewController controller, String url) {
          // print("onLoadStart");
        },
        onLoadStop: (InAppWebViewController ccc, String url) async {

        },
        onProgressChanged: (c,progress){

        },
      ),
    );
  }
}
