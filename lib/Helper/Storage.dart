

import 'dart:convert';

import 'package:get_storage/get_storage.dart';
import 'package:manazel_alabrar/model/Country.dart';

class Storage{

  static GetStorage getStorage = GetStorage();

  static Future<bool> saveCountry(Country country) async {
    await getStorage.write("country", jsonEncode(country.toJson()));
    return true;
  }

  static Country getCountry() {
    return Country.fromJson(jsonDecode(getStorage.read("country")));
  }

  static Future<bool> saveUser(dynamic data) async {
    await getStorage.write("user", jsonEncode(data));
    return true;
  }
  static Future<bool> setPermissionMicOk() async{
    await getStorage.write("PermissionMicOk", true);
  }

  static Future<bool> registerDevice() async {
    await getStorage.write("deviceRegistered", true);
    return true;
  }

  static Future<Map> getUser() async {
    return jsonDecode(getStorage.read("user"));
  }

  static Future<bool> removeUser() async {
    await getStorage.remove("user");
    return true;
  }

  static Future<bool> saveStyle(int value) async {
    await getStorage.write("style", value);
    return true;
  }

  static Future<bool> saveLocale(String value) async {
    await getStorage.write("locale", value);
    return true;
  }

  static Future<int> getLocale() async {
    return getStorage.read("locale");
  }

  static Future<int> getStyle() async {
    return getStorage.read("style");
  }

  static Future<bool> userExist() async {
    return getStorage.hasData("user");
  }

  static Future<bool> deviceRegistered() async {
    return getStorage.hasData("deviceRegistered");
  }

  static Future<bool> countryExist() async {
    return getStorage.hasData("country");
  }

  static Future<bool> styleExist() async {
    return getStorage.hasData("style");
  }

  static Future<bool> permissionMicExist() async{
    return getStorage.hasData("PermissionMicOk");
  }


}