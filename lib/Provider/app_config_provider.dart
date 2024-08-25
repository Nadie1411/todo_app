import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppConfigProvider extends ChangeNotifier
{
  String appLanguage = 'en';
  ThemeMode appMode = ThemeMode.light;

  void changeAppLanguage(String newAppLanguage)
  {
    if(appLanguage == newAppLanguage)
      {
        return ;
      }
    appLanguage = newAppLanguage;
    notifyListeners();
}
  void changeMode(ThemeMode newMode)
  {
    if(appMode == newMode)
      {
        return ;
      }
    appMode = newMode;
    notifyListeners();
  }

  saveLanguage(String newAppLanguage) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString('newAppLanguage', newAppLanguage);
  }

  getLanguage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    appLanguage = prefs.getString('newAppLanguage') ?? 'en';
    notifyListeners();
  }

  saveTheme(bool isDark) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setBool('theme', isDark);

    getTheme() async {
      SharedPreferences preferences = await SharedPreferences.getInstance();
      bool theme = preferences.getBool('theme') ?? false;
      appMode = theme ? ThemeMode.light : ThemeMode.dark;
      notifyListeners();
    }
  }
}