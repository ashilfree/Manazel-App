
import 'package:flutter/material.dart';
import 'package:manazel_alabrar/model/MessageData.dart';
import 'package:sizer/sizer.dart';
import 'package:get/get.dart';


class ItemMessageText extends StatelessWidget {

  final MessageData messageData;
  final String message;
  final bool isMe;
  final bool isStep;
  final Color textColor;
  const ItemMessageText({Key key, this.messageData, this.isMe = false, this.message, this.isStep = false, this.textColor}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.symmetric(vertical: 2, horizontal: 20),
        child: Column(
          crossAxisAlignment: isMe?CrossAxisAlignment.start:CrossAxisAlignment.end,
          children: [
            Container(
              decoration: BoxDecoration(
                  color: isMe ? Colors.white:Get.theme.primaryColor,
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(15),
                    topLeft: Radius.circular(15),
                    bottomLeft: !isMe? Radius.circular(15):Radius.circular(0),
                    bottomRight: !isMe? Radius.circular(0):Radius.circular(15),
                  ),
                  boxShadow: [
                    BoxShadow(
                        blurRadius: 0.1,
                        color: Colors.grey.withOpacity(0.9)
                    ),
                  ]

              ),
              padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 12.0),
              margin: EdgeInsets.only(right: !isMe?0:28, left: !isMe?28:0),
              child: Text(messageData.message ?? "message",
                style: TextStyle(
                    fontSize: 12.sp,
                    color: textColor !=null ? textColor : isMe? Get.theme.primaryColor:Colors.white,
                    fontWeight: FontWeight.w600),
              ),
            ),
            Row(
              mainAxisAlignment: isMe?MainAxisAlignment.start:MainAxisAlignment.end,
              children: [
                !isMe?  Row(
                  children: [
                    Icon(Icons.check,size: 12.sp,color: Get.theme.primaryColor,),
                    // Padding(
                    //   padding: const EdgeInsets.symmetric(horizontal: 4),
                    //   child: Text("00:00",
                    //     style: TextStyle(
                    //         fontSize: 10.sp,color: Colors.grey)
                    //     ,textDirection: TextDirection.ltr,),
                    // )
                  ],
                ):Container(),
                isMe ?  Row(
                  children: [
                    Container(
                      width: 10,
                      height: 10,
                      padding: EdgeInsets.all(2),
                      decoration: BoxDecoration(
                        color: Get.theme.primaryColor,
                        shape: BoxShape.circle,
                        border: Border.all(color: Get.theme.primaryColor,width: 1.5),
                      ),
                      child: Center(
                        child: Image.asset('assets/images/logo.png'),
                      ),
                    ),
                    // Padding(
                    //   padding: const EdgeInsets.symmetric(horizontal: 4),
                    //   child: Text("11:11",
                    //     style: TextStyle(
                    //         fontSize: 10.sp,color: Colors.grey)
                    //     ,textDirection: TextDirection.ltr,),
                    // )
                  ],
                ):Container(),
              ],
            )
          ],
        )
    );
  }
}
