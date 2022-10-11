

import 'package:get/get.dart';

bool get isArabic{
  return Get.locale.languageCode == "ar";
}



class MyTranslations extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
    'en_US': en,
    'ar_AE': ar,
    'pt': {
      'title': 'Olá de Portugal',
    },
    'pt_BR': {
      'title': 'Olá do Brasil',
    },
  };
}




Map<String,String> en = {

    "nameApp": "Manazel",

    "tabMore.aboutUs": "About Us",
    "tabMore.terms": "Terms And Conditions",
    "tabMore.support": "Support",
    "tabMore.guid": "App Guidelines",
    "tabMore.contactUs": "Contact tUs",
    "tabMore.changeLanguage": "ChangeLanguage",
    "tabMore.logOut": "Log Out",


    "tabHome.hasRead": "has read her ayah",
    "tabHome.dayAgo": "a day ago",


    "myAccount.editPhoto": "Edit my photo",
    "myAccount.editMyProfile": "Edit my profile",
    "myAccount.myAssignment": "My assignment",
    "myAccount.myTeacher": "My Teacher",
    "myAccount.notifications": "Notifications",
    "myAccount.myLevel": "My level",
    "myAccount.SelectLevel": "Select level",


    "messages.addYourEmail": "please add your Email",
    "messages.checkEmail": "please check your email",
    "messages.addPhone": "please add your Phone",
    "messages.addQuranParts": "please add your quranParts",
    "messages.quranParts": "Quran hifth parts",
    "messages.availableTimes": "please add your Available times",
    "messages.addWorkingHour": "please add your Working hours",
    "messages.addPassword": "please add your Password",
    "messages.addConfirmPassword": "please add your Confirm password",
    "messages.passwordNotEquals": "Passwords are not equal",
    "messages.must_not_empty": "must not empty",
    "messages.addyourMatery": "please add your Matery certification number",


    "textFiled.email": "Email",
    "textFiled.Materycertification": "Matery certification number",
    "textFiled.phone": "Phone",
    "textFiled.dateBirth": "Date of Birth",
    "textFiled.hifthParts": "Quran hifth parts",
    "textFiled.availableTimes": "Available times",
    "textFiled.workingHour": "Working hours",
    "textFiled.password": "Password",
    "textFiled.confirmPassword": "Confirm password",

    "editProfile.workingHour": "Edit",
    "editProfile.changePassword": "Change Password",
    "editProfile.change": "Change",



    "myAssignment.appBar": "My Assignment",
    "myAssignment.part1": "Part One --> Sub Level 1",
    "myAssignment.view": "VIEW",
    "myAssignment.tajweed": "Tajweed Lesson Link",
    "myAssignment.tafsir": "Tafsir Link",
    "myAssignment.error": "error",

    "notifications.appBar": "Notifications",
    "notifications.empty": "Notification is Empty",

    "myStudents.appBar": "My Students",

    "myTeacher.empty": "Teacher Not Found",
    "myTeacher.group": "Group Teacher",
    "myTeacher.openChat": "OPEN CHAT",


    "intro.chooseLanguage": "Choose your language",
    "intro.chooseCountry": "Choose your Country",
    "intro.selectCountry": "select country",
    "intro.CONTINUE": "CONTINUE",
    "intro.selectLanguage": "select language",

    "dialog.ok": "ok",
    "dialog.cancel": "cancel",

    "recordVoice.level": "Aya placement test",
    "recordVoice.record": "Record",
    "recordVoice.send": "send",


    "signIn.login": "LOGIN",
    "signIn.selectName": "please add your name",
    "signIn.name": "Username",
    "signIn.selectPassword": "please add your password",
    "signIn.password": "Password",
    "signIn.rememberMe": "Remember me",
    "signIn.signIn": "SIGN IN",
    "signIn.create": "Create an Account",
    "signIn.youAreTeacher": "YOU ARE A TEACHER",
    "signIn.youAreStudent": "YOU ARE A STUDENT",

    "signUp.email": "Email",
    "signUp.optional": "optional",
    "signUp.phone": "Phone",
    "signUp.MogazhOrNot": "Mogazh or not ?",
    "signUp.Continue_For_Level_Test": "Continue For Level Test",


    "aboutUs.appBar": "About Us",
    "guid.appBar": "CLOSE",
    "button.CONTINUE": "CONTINUE",

    "recordVoice.hear": "Hear",


    "contactUs.Write_your_problem": "Write your problem or message here",
    "contactUs.Contact_us": "Contact us",
    "contactUs.Support": "Support",
    "contactUs.name": "Name",
    "contactUs.phone": "Phone Number",

    "terms.Terms_And_Conditions": "Terms And Conditions",

    "bottomBar.Home": "Home",
    "bottomBar.My_Student": "My Student",
    "bottomBar.My_Teacher": "My Teacher",
    "bottomBar.My_Account": "My Account",
    "bottomBar.My_More": "More",







    "messages.bannedGroup": "group is stopped",

    "chat.dropDown1": "Read",
    "chat.dropDown2": "Not Read",
    "chat.dropDown3": "Trmim",
    "chat.dropDown4": "Stopped",
    "chat.swip1": "",
    "chat.noMoreMessage": "",
    "chat.empty": "Empty",
    "chat.typeMessage": "Type Message .... ",

};

Map<String,String> ar = {

    "nameApp": "منازل",


    "tabMore.aboutUs": "معلومات عنا",
    "tabMore.terms": "الأحكام والشروط",
    "tabMore.support": "الدعم",
    "tabMore.guid": "إرشادات التطبيق",
    "tabMore.contactUs": "اتصل بنا",
    "tabMore.changeLanguage": "تغيير اللغة",
    "tabMore.logOut": "تسجيل خروج",


    "tabHome.hasRead": "قرأ آياتها",
    "tabHome.dayAgo": "قبل يوم",


    "myAccount.editPhoto": "تحرير صورتي",
    "myAccount.editMyProfile": "تعديل ملفي الشخصي",
    "myAccount.myAssignment": "واجبي",
    "myAccount.myTeacher": "معلمي",
    "myAccount.notifications": "إشعارات",
    "myAccount.myLevel": "مستواي",
    "myAccount.SelectLevel": "اختار مستوى",


    "messages.addYourEmail": "الرجاء إضافة البريد الإلكتروني الخاص بك",
    "messages.checkEmail": "تفقد بريدك الالكتروني من فضلك",
    "messages.addPhone": "الرجاء إضافة هاتفك",
    "messages.addQuranParts": "الرجاء إضافة أجزاء القرآن الخاص بك",
    "messages.quranParts": "كم جزءاً تحفظين",
    "messages.availableTimes": "يرجى إضافة الأوقات المتاحة الخاصة بك",
    "messages.addWorkingHour": "الرجاء إضافة ساعات العمل الخاصة بك",
    "messages.addPassword": "الرجاء إضافة كلمة المرور الخاصة بك",
    "messages.addConfirmPassword": "الرجاء إضافة تأكيد كلمة المرور الخاصة بك",
    "messages.passwordNotEquals": "كلمات المرور غير متساوية",
    "messages.must_not_empty": "يجب ألا تفرغ",
    "messages.addyourMatery": "يرجى إضافة رقم شهادة Matery الخاصة بك",


    "textFiled.email": "البريد الالكتروني",
    "textFiled.Materycertification": "عدد شهادات الإتقان (اذا لم تحصلي على واحدة اكتبي صفر)",
    "textFiled.phone": "الجوال",
    "textFiled.dateBirth": "تاريخ الولادة",
    "textFiled.hifthParts": "اجزاء القرآن الكريم",
    "textFiled.availableTimes": "كم ساعة تستطيعين التطوع (يوما)",
    "textFiled.workingHour": "ساعات العمل",
    "textFiled.password": "كلمة السر",
    "textFiled.confirmPassword": "تأكيد كلمة السر",

    "editProfile.workingHour": "تحرير",
    "editProfile.changePassword": "تغير كلمة السر",
    "editProfile.change": "تغير",

    "recordVoice.hear": "استماع",


    "myAssignment.appBar": "مهمتي",
    "myAssignment.part1": "الجزء الأول -> المستوى الفرعي 1",
    "myAssignment.view": "فتح",
    "myAssignment.tajweed": "رابط درس التجويد",
    "myAssignment.tafsir": "تفسير لينك",
    "myAssignment.error": "خطأ",

    "notifications.appBar": "الاشعارات",
    "notifications.empty": "الاشعارات فارغه",

    "myStudents.appBar": "طلابي",

    "myTeacher.empty": "المعلم غير موجود",
    "myTeacher.group": "معلم المجموعه",
    "myTeacher.openChat": "فتح المحادثة",


    "intro.chooseLanguage": "اختار اللغة",
    "intro.chooseCountry": "اختار البلد",
    "intro.selectCountry": "اختار البلد",
    "intro.CONTINUE": "استمرار",
    "intro.selectLanguage": "تغير اللغة",

    "dialog.ok": "قبول",
    "dialog.cancel": "رفض",

    "recordVoice.level": "اية اختبار تحديد المستوى",
    "recordVoice.record": "تسجيل",
    "recordVoice.send": "ارسال",


    "signIn.login": "تسجيل الدخول",
    "signIn.selectName": "من فضلك قم لأدخال الاسم",
    "signIn.name": "الاسم",
    "signIn.selectPassword": "من فضلك قم بأدخال كلمة السر",
    "signIn.password": "كلمة السر",
    "signIn.rememberMe": "تذكرني",
    "signIn.signIn": "تسجيل الدخول",
    "signIn.create": "إنشاء حساب",
    "signIn.youAreTeacher": "تسجيل دخول معلمة",
    "signIn.youAreStudent": "تسجيل دخول طالبة",

    "signUp.email": "البريد الالكتروني",
    "signUp.optional": "اختياري",
    "signUp.phone": "الجوال",
    "signUp.MogazhOrNot": " هل انت خاتمة ؟ اضغطي على المربع اذا نعم ، موجزة أم لا ؟",
    "signUp.Continue_For_Level_Test": "استمارار الى اختبار المستوى",


    "aboutUs.appBar": "معلومات عنا",
    "guid.appBar": "اغلاق",
    "button.CONTINUE": "استمر",


    "contactUs.Write_your_problem": "اكتب مشكلتك أو رسالتك هنا",
    "contactUs.Contact_us": "اتصل بنا",
    "contactUs.Support": "الدعم",
    "contactUs.name": "الاسم",
    "contactUs.phone": "الجوال",
    "terms.Terms_And_Conditions": "الشروط والاحكام",

    "bottomBar.Home": "الرئيسية",
    "bottomBar.My_Student": "طلابي",
    "bottomBar.My_Teacher": "معلمي",
    "bottomBar.My_Account": "حسابي",
    "bottomBar.My_More": "المزيد",



    "messages.bannedGroup": "تم ايقاف الجروب",

    "chat.dropDown1": "قرأ",
    "chat.dropDown2": "لم يقرأ",
    "chat.dropDown3": "مترمم",
    "chat.dropDown4": "متوقف",

    "chat.swip1": "اسحب للاعلى لتحميل المزيد",
    "chat.noMoreMessage": "لا يوجد رسائل اخرى للتحميل",
    "chat.empty": "لا يوجد رسائل",
    "chat.typeMessage": "اكتب رسالتك  …  ",

};

