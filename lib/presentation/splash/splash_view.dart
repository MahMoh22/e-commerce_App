import 'dart:async';

import 'package:e_commerce_app/app/app_prefs.dart';
import 'package:e_commerce_app/app/di.dart';
import 'package:e_commerce_app/presentation/resources/assets_manager.dart';
import 'package:e_commerce_app/presentation/resources/color_manager.dart';
import 'package:e_commerce_app/presentation/resources/constants_manager.dart';
import 'package:e_commerce_app/presentation/resources/routes_manager.dart';
import 'package:flutter/material.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  Timer? _timer;
  final AppPreferences _appPreferences = instance<AppPreferences>();

  _startDelay() {
    _timer =
        Timer(const Duration(seconds: AppConstants.splashDuration), _goNext);
  }

  _goNext() async {
    _appPreferences.isuserLoggedin().then((isuserLoggedin) {
      if (isuserLoggedin) {
        // navigate to main screen
        Navigator.pushReplacementNamed(context, Routes.mainRoute);
      } else {
        _appPreferences
            .isOnboardingScreenViewed()
            .then((isOnboardingScreenViewed) {
          if (isOnboardingScreenViewed) {
            // navigate to login screen
            Navigator.pushReplacementNamed(context, Routes.loginRoute);
          } else {
            // navigate to onbourding screen
            Navigator.pushReplacementNamed(context, Routes.onboardingRoute);
          }
        });
      }
    });
  }

  @override
  void initState() {
    _startDelay();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.primary,
      body: const Center(
        child: Image(image: AssetImage(ImageAssets.splashLogo)),
      ),
    );
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}
