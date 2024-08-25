import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/Home/auth/login_screen.dart';
import 'package:todo_app/Home/auth/register_screen.dart';
import 'package:todo_app/Home/edit_screen.dart';
import 'package:todo_app/Home/home_Screen.dart';
import 'package:todo_app/Provider/list_provider.dart';
import 'package:todo_app/Provider/user_provider.dart';
import 'package:todo_app/theme_data.dart';

import 'Provider/app_config_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Platform.isAndroid
      ? await Firebase.initializeApp(
          options: FirebaseOptions(
              apiKey: "AIzaSyD326v-EYbECNHLkvkTWQBB3bQvQU0NWCI",
              appId: "com.example.todo_app",
              messagingSenderId: "640488358334",
              projectId: "todo-app-ba3ff"))
      : await Firebase.initializeApp();
  //await FirebaseFirestore.instance.disableNetwork();
  await FirebaseFirestore.instance.enableNetwork();
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(
      create: (context) => AppConfigProvider(),
    ),
    ChangeNotifierProvider(
      create: (context) => ListProvider(),
    ),
    ChangeNotifierProvider(create: (context) => UserProvider())
  ], child: MyApp()));
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
      initialRoute: LoginScreen.routeName,
      routes: {
        HomeScreen.routeName: (context) => HomeScreen(),
        RegisterScreen.routeName: (context) => RegisterScreen(),
        LoginScreen.routeName: (context) => LoginScreen(),
        EditScreen.routeName: (context) => EditScreen()
      },
      theme: MyTheme.lightTheme,
      darkTheme: MyTheme.darkTheme,
      themeMode: provider.appMode,
    );
  }
}
