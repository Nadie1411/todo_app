import 'package:flutter/material.dart';
import 'package:todo_app/Home/home_Screen.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: HomeScreen.routeName,
      routes: {
        HomeScreen.routeName: (cotext) => HomeScreen(),
      },
      theme: ThemeData(),
    );
  }
}
