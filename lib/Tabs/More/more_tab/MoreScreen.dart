import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:manazel_alabrar/BottomBar/MainScreen.dart';
import 'package:manazel_alabrar/Helper/Storage.dart';
import 'package:manazel_alabrar/Tabs/More/About/AboutUsScreen.dart';
import 'package:manazel_alabrar/Tabs/More/AppGuideliens/AppGuidelinesScreen.dart';
import 'package:manazel_alabrar/Tabs/More/Changelanguage/ChangeLanguageScreen.dart';
import 'package:manazel_alabrar/Tabs/More/ContactUs/ContactUsScreen.dart';
import 'package:manazel_alabrar/Tabs/More/Support/SupportScreen.dart';
import 'package:manazel_alabrar/Tabs/More/Terms/t&cScreen.dart';
import 'package:manazel_alabrar/Tabs/More/more_tab/MoreController.dart';
import 'package:manazel_alabrar/model/User.dart';
import 'package:sizer/sizer.dart';
import 'package:provider/provider.dart';


class MoreTab extends GetView<MoreController> {

  const MoreTab({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return SingleChildScrollView(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(height: 20,),
            Image.asset(
              "assets/images/c_logo.png",
              height: 120,
              width: 120,
            ),
            MoreItems(
              text:"tabMore.aboutUs".tr,
              image: "assets/images/about_us_icon.png",
              onTap: () {
                Get.toNamed(AboutUsScreen.routeName);
              },
            ),

            MoreItems(
              text: "tabMore.terms".tr,
              image: "assets/images/t&c_icon.png",
              onTap: () {
                Get.toNamed(Terms.routeName);
              },
            ),

            MoreItems(
              text: "tabMore.support".tr,
              image: "assets/images/support_icon.png",
              onTap: () {
                Get.toNamed(SupportScreen.routeName);
              },
            ),

            MoreItems(
              text: "tabMore.guid".tr,
              image: "assets/images/app_guidline_icon.png",
              onTap: () {
                Get.toNamed(AppGuidelinesScreen.routeName);
              },
            ),

            MoreItems(
              text: "tabMore.contactUs".tr,
              image: "assets/images/contact_us_icon.png",
              onTap: () {
                Get.toNamed(ContactUsScreen.routeName);
              },
            ),

            MoreItems(
              text: "tabMore.changeLanguage".tr,
              image: "assets/images/language.png",
              onTap: () {
                Get.toNamed(ChangeLanguageScreen.routeName);
              },
            ),


            Consumer<User>(
              builder: (context,user,w){

                if(user.isNull){
                  return Container();
                }

                return MoreItems(
                  text: "tabMore.logOut".tr,
                  image: "assets/images/language.png",
                  onTap: () async{
                    controller.logOut(user);
                  },
                  showDivider: false,
                );

              },
            ),

            SizedBox(
              height: 7,
            ),
          ],
        ),
      ),
    );
  }
}

class MoreItems extends StatelessWidget {
  final String text;
  final String image;
  final String routeName;
  final Function onTap;
  final bool showDivider;
  final bool loadingTrailing;
  const MoreItems({Key key, this.text, this.image, this.routeName, this.onTap, this.showDivider = true, this.loadingTrailing = false})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          onTap: onTap,
          title: Text(text,style: TextStyle(
            fontSize: 13.sp
          ),),
          trailing:loadingTrailing ? Container(
            width: 20.sp,height: 20.sp,
            child: CircularProgressIndicator(),
          ): Image.asset(
            image,
            height: 30,
            width: 30,
          ),
        ),
        showDivider ? Divider(
          thickness: 1,
          height: 5,
        ) : Container(),
      ],
    );

  }
}
