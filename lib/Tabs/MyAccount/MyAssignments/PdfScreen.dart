

import 'package:flutter/material.dart';
import 'package:flutter_cached_pdfview/flutter_cached_pdfview.dart';
import 'package:get/get.dart';



class PdfScreenApp extends StatelessWidget {
  static const String routeName = "PdfScreen";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PDF().cachedFromUrl(
        Get.arguments,
        placeholder: (progress) => Center(child: Text('$progress %')),
        errorWidget: (error) => Center(child: Text(error.toString())),
      ),
    );
  }
}
