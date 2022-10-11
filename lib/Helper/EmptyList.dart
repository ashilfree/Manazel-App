

import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';


class EmptyList extends StatelessWidget {
  final String text;
  final IconData icon;
  final Color iconColor;
  const EmptyList({Key key, this.text = " ", this.icon = Icons.list, this.iconColor = Colors.blueGrey}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
          physics: AlwaysScrollableScrollPhysics(),
          padding: EdgeInsets.all(16.0),
          child:Container(
              height: MediaQuery.of(context).size.height * 70 / 100,
              width: MediaQuery.of(context).size.width,
              alignment: Alignment.center,
              child: Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(icon,size:80.sp,color: iconColor,),
                      SizedBox(height: 10,),
                      Text(text,textAlign: TextAlign.center,style: Theme.of(context).textTheme.headline2.copyWith(fontSize: 15.sp),),
                    ],
                  )
              )
          )
      ),
    );
  }
}
