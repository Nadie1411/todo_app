import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/Home/home_Screen.dart';
import 'package:todo_app/theme_data.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'Provider/app_config_provider.dart';

void main() {
  runApp(ChangeNotifierProvider
    (
    create: (context) => AppConfigProvider(),
      child: MyApp()));
}

class MyApp extends StatelessWidget
{
  @override
  Widget build(BuildContext context)
  {
    var provider = Provider.of<AppConfigProvider>(context);
    return MaterialApp(
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      locale: Locale(provider.appLanguage),
      debugShowCheckedModeBanner: false,
      initialRoute: HomeScreen.routeName,
      routes: {
        HomeScreen.routeName: (context) => HomeScreen(),
      },
      theme: MyTheme.lightTheme,
      darkTheme: MyTheme.darkTheme,
      themeMode: provider.appMode,


    );
  }
}
