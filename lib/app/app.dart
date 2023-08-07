import 'package:e_commerce_app/presentation/resources/routes_manager.dart';
import 'package:e_commerce_app/presentation/resources/theme_manager.dart';
import 'package:flutter/material.dart';

class MyApp extends StatefulWidget {
  const MyApp._internal(); //named constractor
  static const MyApp _instance = MyApp._internal(); //single instance
  factory MyApp() => _instance; //factory
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      onGenerateRoute: RoutesGenerator.getRoute,
      initialRoute: Routes.splashRoute,
      theme: themeManager(),
    );
  }
}
