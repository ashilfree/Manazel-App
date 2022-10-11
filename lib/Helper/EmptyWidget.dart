

import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';


class EmptyWidget extends StatelessWidget {
  final IconData icon;
  final String title;
  final double textSize;
  final double iconSize;
  const EmptyWidget({Key key, this.icon, this.title, this.textSize, this.iconSize}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
          child:Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(title,textAlign: TextAlign.center,style: TextStyle(color: Colors.grey.withOpacity(0.7),fontSize: textSize ?? 20.sp),),
              Icon(icon,size:iconSize ?? 20.sp,color: Colors.grey.withOpacity(0.5),),
            ],
          )
      ),
    );
  }
}




