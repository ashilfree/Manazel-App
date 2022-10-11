


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:manazel_alabrar/Helper/Storage.dart';
import 'package:manazel_alabrar/Style/Style.dart';
import 'package:manazel_alabrar/main.dart';



class StyleController with ChangeNotifier{

  changeStyle(StyleApp styleChaned)async{
    await Storage.saveStyle(styleChaned.index);
    style = styleChaned;
    notifyListeners();
  }

  ThemeData themeData(bool isDarkTheme, BuildContext context) {
    return ThemeData(
        primaryColor: Color(0xff8d7249),
        primarySwatch: Colors.brown,
        checkboxTheme: CheckboxThemeData(
          fillColor: MaterialStateColor.resolveWith(
                (states) {
              if (states.contains(MaterialState.selected)) {
                return Colors.brown;
              }
              return Colors.white;
            },
          ),
        ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        selectedLabelStyle: TextStyle(
          color: Colors.black
        ),
        unselectedLabelStyle: TextStyle(
            color: Colors.black
        ),
        selectedItemColor: Color(0xff8d7249),
        unselectedItemColor: Color(0xff8d7249).withOpacity(0.5),
        unselectedIconTheme: IconThemeData(
          color: Color(0xff8d7249).withOpacity(0.5)
        ),
        selectedIconTheme:IconThemeData(
            color: Color(0xff8d7249)
        )
      ),
      inputDecorationTheme: InputDecorationTheme(
        fillColor: Color(0xffe8dac5).withOpacity(0.7),
        filled: true,
        enabledBorder: OutlineInputBorder(
            borderSide:
            BorderSide(color: Colors.transparent),
            borderRadius: BorderRadius.circular(10)),
        disabledBorder: OutlineInputBorder(
            borderSide:
            BorderSide(color: Colors.transparent),
            borderRadius: BorderRadius.circular(10)),
        focusedBorder: OutlineInputBorder(
            borderSide:
            BorderSide(color: Colors.transparent),
            borderRadius: BorderRadius.circular(10)),
        errorBorder: OutlineInputBorder(
            borderSide:
            BorderSide(color: Colors.transparent),
            borderRadius: BorderRadius.circular(10)),
        focusedErrorBorder: OutlineInputBorder(
            borderSide:
            BorderSide(color: Colors.transparent),
            borderRadius: BorderRadius.circular(10)),
        contentPadding: EdgeInsets.all(10),
        hintStyle: TextStyle(color: Colors.grey[800]),
        labelStyle: TextStyle(
          fontFamily: "Nunito",
          color: Colors.grey,
          fontSize: 15,
        ),
      ),
      outlinedButtonTheme:OutlinedButtonThemeData(
        style: ButtonStyle(
          minimumSize: MaterialStateProperty.all<Size>(Size(150, 40)),
          side: MaterialStateProperty.all<BorderSide>(
              BorderSide(color: Colors.white)),
          shape: MaterialStateProperty.all<OutlinedBorder>(
              RoundedRectangleBorder(
                side: BorderSide(
                    style: BorderStyle.solid,
                    color: Colors.white,
                    width: 1), // <-- this doesn't work?
                borderRadius: BorderRadius.all(Radius.circular(5)),
              )),
          // foregroundColor: MaterialStateProperty.all<Color>(AppColors.SecondaryButtonText),
          textStyle: MaterialStateProperty.all<TextStyle>(TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w600,
          )),
        ),
      ),
      buttonTheme: ButtonThemeData(
        buttonColor: Color(0xff8d7249),
        padding: EdgeInsets.symmetric(vertical: 8,horizontal: 30),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(5))),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          primary: Color(0xff8d7249),
          padding: EdgeInsets.symmetric(vertical: 8,horizontal: 30),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(5))),
        ),
      ),);
  }

  bool isDark() {
    return style == StyleApp.DARK ? true : false;
  }

  bool isLight() {
    return style == StyleApp.LIGHT ? true : false;
  }

}