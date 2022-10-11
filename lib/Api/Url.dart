


class Url{
  
  // static const String url = "https://manazel.tech/api/";
  static const String url = "http://10.0.2.2:8000/api/";
  static const String get_terms_and_conditions = "users/get_terms_and_conditions";
  static const String get_about_us = "users/get_about_us";
  static const String support_message = "users/support_message";
  static const String contact_us_message = "users/contact_us_message";
  static const String get_app_guide = "users/get_app_guide";
  static const String login = "users/login";
  static const String registerTeacher = "teacher/complete_registration";
  static const String registerStudent = "student/complete_registration";
  static const String reset_password = "users/reset_password";
  static const String country = "country";
  static const String user = "user";
  static const String ayah_test = "ayah/test";
  static const String get_notifications = "users/get_notifications";
  static const String updateUser = "users/update";
  static const String user_read = "users/user_read";
  static const String update_password = "users/update_password";
  static const String getLevel = "users/level";
  static const String get_sub_levels = "users/get_sub_levels";
  static const String set_sub_level = "users/set_sub_level";
  static const String assignment = "users/assignment";
  static const String teacher_groups = "users/teacher_groups";
  static const String group_students = "users/group_students";
  static const String move_to_next_week = "users/move_to_next_week";
  static const String get_reads = "users/get_reads";
  static const String refreshToken = "users/register_push_token";
  static const String sendMessage = "users/send_messages";
  static const String get_messages = "users/get_messages";
  static const String get_teacher = "users/get_teacher";
  static const String set_rec_message = "users/set_rec_message";
  static const String edit_photo = "users/edit_photo";
  static const String logout = "users/logout";
  static const String platform_data = "users/platform_data";


  static String getLink(String link){
    String split = link.split("storage")[1];
    return Url.url.replaceAll("api/", "storage"+split);
  }

  static String getLinkRecordVoice(String link){
    return Url.url.replaceAll("api/", "storage"+"/app/recorded_masseges/$link");
  }

  static String getLinkSettingFiles(String link){
    String data = link.split("storage")[1];
    return Url.url.replaceAll("api/", "storage"+data);
  }

  // /home/u855202855/domains/manazel.tech/public_html/storage/app/settings_files/2d6d5d497f93e9bec386cc5bc01d9598.png


}