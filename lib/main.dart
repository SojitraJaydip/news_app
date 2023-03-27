import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:news_app/view/home/home_screen.dart';

import 'view/splash/splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return  GetMaterialApp(
      theme: ThemeData(
        colorSchemeSeed: Colors.green[700],
        useMaterial3: true,
          appBarTheme: AppBarTheme(
            color: Colors.cyan[700],
            brightness: Brightness.dark,
            elevation: 0,
            iconTheme: Theme.of(context).iconTheme,
          )
      ),
      debugShowCheckedModeBanner: false,
      home:  SplashScreen(),
    );
  }
}

