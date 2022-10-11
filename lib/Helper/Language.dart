

import 'package:get/get.dart';

class Language{
  final int id;
  final String name;
  final String image;
  Language(this.id, this.name, this.image);

  static List<Language> list = [
    Language(1, "Arabic","assets/images/flags/ae.png"),
    Language(2, "English","assets/images/flags/ae.png"),
  ];

  static Language getLanguage() {
    return Get.locale.languageCode == "ar" ? list[0] : list[1];
  }
}