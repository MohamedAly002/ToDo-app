import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class SettingProvider extends ChangeNotifier{
String currentlanguage='en';
ThemeMode currenttheme=ThemeMode.system;



void ChangeTheme(ThemeMode theme){
  currenttheme=theme;
  notifyListeners();
}


void ChangeLanguage(String language){
  currentlanguage=language;
  notifyListeners();
}

 bool isDarkmode(){
 return currenttheme== ThemeMode.dark;
}

}