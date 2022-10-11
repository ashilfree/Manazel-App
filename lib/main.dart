
import 'dart:convert';
import 'dart:typed_data';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:manazel_alabrar/BottomBar/MainScreen.dart';
import 'package:manazel_alabrar/Chat/ChatScreen.dart';
import 'package:manazel_alabrar/Chat/Controller/ChatController.dart';
import 'package:manazel_alabrar/Chat/Controller/ChatRecordVoice.dart';
import 'package:manazel_alabrar/Helper/MyTranslations.dart';
import 'package:manazel_alabrar/Helper/Screen.dart';
import 'package:manazel_alabrar/Helper/Storage.dart';
import 'package:manazel_alabrar/Login/Intro/IntroController.dart';
import 'package:manazel_alabrar/Login/Intro/IntroScreen.dart';
import 'package:manazel_alabrar/Login/RecordVoice/Controller/RecordVoiceController.dart';
import 'package:manazel_alabrar/Login/RecordVoice/RecordVoiceScreen.dart';
import 'package:manazel_alabrar/Login/SignUp/SignUpController.dart';
import 'package:manazel_alabrar/Login/SignUp/SignUpScreen.dart';
import 'package:manazel_alabrar/Login/Splash/SplashController.dart';
import 'package:manazel_alabrar/Login/Splash/SplashScreen.dart';
import 'package:manazel_alabrar/Style/Style.dart';
import 'package:manazel_alabrar/Style/StyleController.dart';
import 'package:manazel_alabrar/Tabs/More/About/AboutUsController.dart';
import 'package:manazel_alabrar/Tabs/More/About/AboutUsScreen.dart';
import 'package:manazel_alabrar/Tabs/More/AppGuideliens/AppGuidelinesController.dart';
import 'package:manazel_alabrar/Tabs/More/AppGuideliens/AppGuidelinesScreen.dart';
import 'package:manazel_alabrar/Tabs/More/Changelanguage/ChangeLanguageController.dart';
import 'package:manazel_alabrar/Tabs/More/Changelanguage/ChangeLanguageScreen.dart';
import 'package:manazel_alabrar/Tabs/More/ContactUs/ContactUsController.dart';
import 'package:manazel_alabrar/Tabs/More/ContactUs/ContactUsScreen.dart';
import 'package:manazel_alabrar/Tabs/More/Support/SupportController.dart';
import 'package:manazel_alabrar/Tabs/More/Support/SupportScreen.dart';
import 'package:manazel_alabrar/Tabs/More/Terms/TermsController.dart';
import 'package:manazel_alabrar/Tabs/More/Terms/t&cScreen.dart';
import 'package:manazel_alabrar/Tabs/MyAccount/EditProfile/EditMyProfile.dart';
import 'package:manazel_alabrar/Tabs/MyAccount/EditProfile/EditProfileController.dart';
import 'package:manazel_alabrar/Tabs/MyAccount/MyAssignments/MyAssignmentController.dart';
import 'package:manazel_alabrar/Tabs/MyAccount/MyAssignments/MyAssignmentScreenStudent.dart';
import 'package:manazel_alabrar/Tabs/MyAccount/MyAssignments/MyAssignmentWebView.dart';
import 'package:manazel_alabrar/Tabs/MyAccount/MyAssignments/PdfScreen.dart';
import 'package:manazel_alabrar/Tabs/MyAccount/Notification/NotificationsController.dart';
import 'package:manazel_alabrar/Tabs/MyAccount/Notification/NotificationsScreenStudent.dart';
import 'package:manazel_alabrar/Tabs/MyStudent/Groups/MyStudentGroupController.dart';
import 'package:manazel_alabrar/Tabs/MyStudent/Students/MyStudentController.dart';
import 'package:manazel_alabrar/Tabs/MyStudent/Students/MyStudentScreen.dart';
import 'package:manazel_alabrar/model/User.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';




dynamic userData;
StyleApp style;
StyleController themeNotifier;


void main() async{

  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  await Firebase.initializeApp();

  if(await Storage.userExist()){
    userData = await Storage.getUser();
    print(userData.toString());
  }

  if(await Storage.styleExist()){
    int value = await Storage.getStyle();
    style = StyleApp.values[value];
  }else{
    style = StyleApp.DARK;
    await Storage.saveStyle(StyleApp.DARK.index);
  }

  runApp(MyApp());

}



class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    GetStorage getStorage = GetStorage();

    bool isArabic(){
      if(getStorage.read("locale")==null){
        return false;
      }
      return getStorage.read("locale").toString() == "ar";
    }

    return MultiProvider(providers: [
      ChangeNotifierProvider(create: (c)=>User.fromJson(userData)),
      ChangeNotifierProvider(create: (c)=>StyleController()),
    ],
      child: Consumer<StyleController>(builder: (context,theme,w){
        themeNotifier = theme;
        return GestureDetector(
          onTap:(){
            // WidgetsBinding.instance.focusManager.primaryFocus?.unfocus();
            closeKeyboard(context);
            // final node = FocusScope.of(context);
          },
          child: Sizer(
            builder: (c,s,w){
              return GetMaterialApp(
                title: 'Mnazel',
                // localizationsDelegates: context.localizationDelegates,
                // supportedLocales: context.supportedLocales,
                // locale: context.locale,
                debugShowCheckedModeBanner: false,
                // It is not mandatory to use named routes, but dynamic urls are interesting.
                initialRoute:SplashScreen.routeName,
                defaultTransition:Transition.cupertino,
                translations: MyTranslations(),
                locale: isArabic() ? Locale('ar', 'AE') : Locale('en', 'US'),
                theme: theme.themeData(style == StyleApp.DARK, context),
                getPages: [
                  GetPage(name: SplashScreen.routeName, page: () => SplashScreen(),binding: SplashScreenB()),
                  GetPage(name: MainScreen.routeName, page: () => MainScreen()),
                  GetPage(name: ChatScreen.routeName, page: () => ChatScreen(), binding: ChatControllerB()),
                  GetPage(name: AboutUsScreen.routeName, page: () => AboutUsScreen(), binding: AboutUsControllerB()),
                  GetPage(name: AppGuidelinesScreen.routeName, page: () => AppGuidelinesScreen(), binding: AppGuidelinesControllerB()),
                  GetPage(name: ChangeLanguageScreen.routeName, page: () => ChangeLanguageScreen(), binding: ChangeLanguageControllerB()),
                  GetPage(name: ContactUsScreen.routeName, page: () => ContactUsScreen(), binding: ContactUsControllerB()),
                  GetPage(name: Terms.routeName, page: () => Terms(), binding: TermsControllerB()),
                  GetPage(name: SupportScreen.routeName, page: () => SupportScreen(),binding: SupportControllerB()),
                  GetPage(name: SignUpScreen.routeName, page: () => SignUpScreen(),binding: SignUpControllerB()),
                  GetPage(name: IntroScreen.routeName, page: () => IntroScreen(),binding: IntroControllerB()),
                  GetPage(name: RecordVoiceScreen.routeName, page: () => RecordVoiceScreen()),
                  GetPage(name: EditMyProfile.routeName, page: () => EditMyProfile(),binding: EditProfileControllerB()),
                  GetPage(name: NotificationsScreenStudent.routeName, page: () => NotificationsScreenStudent(),binding: NotificationsControllerB()),
                  GetPage(name: MyAssignmentScreenStudent.routeName, page: () => MyAssignmentScreenStudent(),binding: MyAssignmentControllerB()),
                  GetPage(name: MyStudentScreen.routeName, page: () => MyStudentScreen(),binding: MyStudentControllerB()),
                  GetPage(name: MyAssignmentWebView.routeName, page: () => MyAssignmentWebView()),
                  GetPage(name: PdfScreenApp.routeName, page: () => PdfScreenApp()),
                ],
              );
            },
          ),
        );
      },),);
  }
}




class MyStudentControllerB extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MyStudentController>(() => MyStudentController());
  }
}
class SupportControllerB extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SupportController>(() => SupportController());
  }
}
class SplashScreenB extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SplashController>(() => SplashController());
  }
}

class MyStudentGroupControllerB extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MyStudentGroupController>(() => MyStudentGroupController());
  }
}

class IntroControllerB extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<IntroController>(() => IntroController());
    Get.lazyPut<ChangeLanguageController>(() => ChangeLanguageController());
  }
}

class SignUpControllerB extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SignUpController>(() => SignUpController());
    Get.lazyPut<RecordVoiceController>(() => RecordVoiceController());
  }
}

class NotificationsControllerB extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<NotificationsController>(() => NotificationsController());
  }
}

class MyAssignmentControllerB extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MyAssignmentController>(() => MyAssignmentController());
  }
}

class EditProfileControllerB extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<EditProfileController>(() => EditProfileController());
  }
}

class ChatControllerB extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ChatController>(() => ChatController());
    Get.lazyPut<ChatRecordVoice>(() => ChatRecordVoice());
  }
}
class AboutUsControllerB extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AboutUsController>(() => AboutUsController());
  }
}
class AppGuidelinesControllerB extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AppGuidelinesController>(() => AppGuidelinesController());
  }
}
class ChangeLanguageControllerB extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ChangeLanguageController>(() => ChangeLanguageController());
  }
}
class ContactUsControllerB extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ContactUsController>(() => ContactUsController());
  }
}
class TermsControllerB extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TermsController>(() => TermsController());
  }
}

Image imageFromBase64String(String base64String) {
  return Image.memory(base64Decode(base64String.toString().split("base64,")[1]));
}

Uint8List dataFromBase64String(String base64String) {
  return base64Decode(base64String);
}

String base64String(Uint8List data) {
  return base64Encode(data);
}


