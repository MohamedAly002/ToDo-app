import 'package:flutter/material.dart';

class MyTheme {
  static const Color PrimaryLightcolor = Color(0xFF5D9CEC);
  static const Color greycolor = Color(0xFFC8C9CB);
  static const Color greenycolor = Color(0xFF61E757);
  static const Color LightScaffoldBackground = Color(0xFFC8C9CB);
  static const Color DarkScaffoldBackground = Color(0xFF060E1E);
  static const Color dark2color = Color(0xFF141922);
  static const Color secondrylightcolor = Colors.black;
  static const Color secondrydarkcolor = Colors.white;

  static final LightTheme = ThemeData(
      primaryColor: PrimaryLightcolor,
      accentColor:secondrylightcolor ,
      scaffoldBackgroundColor: LightScaffoldBackground,
      appBarTheme: AppBarTheme(color: PrimaryLightcolor),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: Colors.transparent,
        elevation: 0,
        selectedIconTheme: IconThemeData(color: PrimaryLightcolor, size: 36),
        unselectedIconTheme: IconThemeData(color: greycolor, size: 36),
      ),
      bottomSheetTheme: BottomSheetThemeData(
        backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
        topRight: Radius.circular(18),
        topLeft: Radius.circular(18),
      ))),
      textTheme: TextTheme(
        headline5: TextStyle(
            fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
        headline6: TextStyle(
            fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black),
      ));

  static final DarkTheme = ThemeData(
      primaryColor: PrimaryLightcolor,
      accentColor: dark2color,
      scaffoldBackgroundColor: DarkScaffoldBackground,
      appBarTheme: AppBarTheme(color: PrimaryLightcolor),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: Colors.transparent,
        elevation: 0,
        selectedIconTheme: IconThemeData(color: PrimaryLightcolor, size: 36),
        unselectedIconTheme: IconThemeData(color: greycolor, size: 36),
      ),
      bottomSheetTheme: BottomSheetThemeData(
        backgroundColor: dark2color,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(18),
                topLeft: Radius.circular(18),
              ))),
      textTheme: TextTheme(
        headline5: TextStyle(
            fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
        headline6: TextStyle(
            fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
      ));
}
