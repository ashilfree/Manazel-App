import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:manazel_alabrar/Helper/EmptyList.dart';
import 'package:manazel_alabrar/Helper/Loading.dart';
import 'package:manazel_alabrar/Helper/VideoCustom.dart';
import 'package:manazel_alabrar/Tabs/Home/HomeController.dart';
import 'package:manazel_alabrar/model/Home.dart';


class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with AutomaticKeepAliveClientMixin{

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return _HomeScreen();
  }
  @override
  bool get wantKeepAlive => true;
}


class _HomeScreen extends GetView<HomeController> {
  const _HomeScreen({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {

    return NestedScrollView(
        physics: ClampingScrollPhysics(),
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverList(
              delegate: SliverChildListDelegate([
                Obx((){

                  if(controller.loading.value ){
                    return Container(height: 230,);
                  }

                  return Container(
                    height: 230,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20.0),
                      child: controller.videoCustom = VideoCustom(
                        url: controller.home.value.homeVideo.setting,
                      ),
                    ),
                  );

                })
              ]),
            ),
          ];
        },
        body:Obx((){

          if(controller.loading.value ){
            return LoadingPage();
          }

          if(controller.loading.value  && controller.home.value.status.isEmpty){
            return EmptyList();
          }

          return ScrollConfiguration(
            behavior: MyBehavior(),
            //todo wrap with expanded in flex
            child: ListView.builder(
                itemCount: controller.home.value.status.length,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  HomeNotification homeNotification = controller.home.value.status[index];
                  return ItemStatus(homeNotification: homeNotification,);
                }),
          );
        })
    );
  }
}

class ItemStatus extends StatelessWidget {
  final HomeNotification homeNotification;
  const ItemStatus({Key key, this.homeNotification}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          title: RichText(
              textAlign: TextAlign.start,
              text: TextSpan(children: [
                TextSpan(
                  text: "${homeNotification.username} ",
                  style: TextStyle(
                      fontSize: 17,
                      color: Color(0xff7d643d),
                      fontWeight: FontWeight.bold),
                ),
                TextSpan(
                    text: "tabHome.hasRead".tr,
                    style: TextStyle(
                        fontSize: 17,
                        color: Colors.black54)),
              ])),
          trailing: Text(
            homeNotification.createdAt,
            style: TextStyle(
                fontSize: 16, color: Color(0xff7d643d)),
          ),
        ),
        Divider(
          color: Color(0xff8d7249),
          thickness: 1,
        )
      ],
    );
  }
}

class MyBehavior extends ScrollBehavior {
  @override
  Widget buildViewportChrome(BuildContext context, Widget child, AxisDirection axisDirection) {
    return child;
  }
}