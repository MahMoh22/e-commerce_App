import 'package:e_commerce_app/app/di.dart';
import 'package:e_commerce_app/presentation/forgot_password/view/forgot_password_view.dart';
import 'package:e_commerce_app/presentation/login/view/login_view.dart';
import 'package:e_commerce_app/presentation/main/main_view.dart';
import 'package:e_commerce_app/presentation/onboarding/view/onboarding_view.dart';
import 'package:e_commerce_app/presentation/register/view/register_view.dart';
import 'package:e_commerce_app/presentation/resources/strings_manager.dart';
import 'package:e_commerce_app/presentation/splash/splash_view.dart';
import 'package:e_commerce_app/presentation/store_details/view/store_details_view.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class Routes {
  static const String splashRoute = "/";
  static const String onboardingRoute = "/onboarding";
  static const String loginRoute = "/login";
  static const String registerRoute = "/register";
  static const String forgotPasswordRoute = "/forgotPassword";
  static const String mainRoute = "/main";
  static const String storeDetailsRoute = "/storeDetails";
}

class RoutesGenerator {
  static Route<dynamic> getRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.splashRoute:
        return MaterialPageRoute(builder: (_) => const SplashView());
      case Routes.onboardingRoute:
        return MaterialPageRoute(builder: (_) => const OnboardingView());
      case Routes.loginRoute:
        initLoginModule();
        return MaterialPageRoute(builder: (_) => const LoginView());
      case Routes.registerRoute:
        initRegisterModule();
        return MaterialPageRoute(builder: (_) => const RegisterView());
      case Routes.forgotPasswordRoute:
        initResetPasswordModule();
        return MaterialPageRoute(builder: (_) => const ForgotPasswordView());
      case Routes.mainRoute:
        initHomeModule();
        return MaterialPageRoute(builder: (_) => const MainView());
      case Routes.storeDetailsRoute:
        initDetailsModule();
        return MaterialPageRoute(builder: (_) => const StoreDetailsView());
      default:
        return undefindRoute();
    }
  }

  static Route<dynamic> undefindRoute() {
    return MaterialPageRoute(
        builder: (_) => Scaffold(
              appBar: AppBar(
                title: Text(AppStrings.noRouteFound.tr()),
              ),
              body: Center(
                child: Text(AppStrings.noRouteFound.tr()),
              ),
            ));
  }
}
