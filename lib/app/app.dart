import 'package:e_commerce_app/app/app_prefs.dart';
import 'package:e_commerce_app/app/di.dart';
import 'package:e_commerce_app/presentation/resources/routes_manager.dart';
import 'package:e_commerce_app/presentation/resources/theme_manager.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class MyApp extends StatefulWidget {
  const MyApp._internal(); //named constractor
  static const MyApp _instance = MyApp._internal(); //single instance
  factory MyApp() => _instance; //factory
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final AppPreferences _appPreferences = instance<AppPreferences>();
  @override
  void didChangeDependencies() {
    _appPreferences.getLocale().then((local) => {context.setLocale(local)});
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      debugShowCheckedModeBanner: false,
      onGenerateRoute: RoutesGenerator.getRoute,
      initialRoute: Routes.splashRoute,
      theme: themeManager(),
    );
  }
}
