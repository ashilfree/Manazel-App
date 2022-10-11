
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class CustomTextGrey extends StatelessWidget {
  final String text;
  final double size;
  CustomTextGrey(this.text,{this.size});
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(text,textAlign: TextAlign.center,style: TextStyle(color: Colors.grey.withOpacity(0.7),fontSize: size ?? 20.sp),),
    );
  }
}
