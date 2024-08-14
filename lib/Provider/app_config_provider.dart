import 'package:flutter/material.dart';

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
}