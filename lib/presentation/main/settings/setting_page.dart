import 'package:e_commerce_app/app/app_prefs.dart';
import 'package:e_commerce_app/app/di.dart';
import 'package:e_commerce_app/data/data_source/local_data_source.dart';
import 'package:e_commerce_app/presentation/resources/assets_manager.dart';
import 'package:e_commerce_app/presentation/resources/languge_manager.dart';
import 'package:e_commerce_app/presentation/resources/routes_manager.dart';
import 'package:e_commerce_app/presentation/resources/strings_manager.dart';
import 'package:e_commerce_app/presentation/resources/values_manager.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:flutter_svg/svg.dart';
import 'dart:math' as math;

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  final AppPreferences _appPreferences = instance<AppPreferences>();
  final LocalDataSource _localDataSource = instance<LocalDataSource>();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ListView(
        padding: const EdgeInsets.all(AppPadding.p12),
        children: [
          ListTile(
            leading: SvgPicture.asset(ImageAssets.changeLangIc),
            title: Text(
              AppStrings.changeLang.tr(),
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            trailing: Transform(
              alignment: Alignment.center,
              transform: Matrix4.rotationY(isRtl() ? math.pi : 0),
              child: SvgPicture.asset(ImageAssets.settingsRightArrowIc),
            ),
            onTap: () {
              _changeAppLang();
            },
          ),
          ListTile(
            leading: SvgPicture.asset(ImageAssets.contactUsIc),
            title: Text(
              AppStrings.contactUs.tr(),
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            trailing: Transform(
              alignment: Alignment.center,
              transform: Matrix4.rotationY(isRtl() ? math.pi : 0),
              child: SvgPicture.asset(ImageAssets.settingsRightArrowIc),
            ),
            onTap: () {},
          ),
          ListTile(
            leading: SvgPicture.asset(ImageAssets.inviteFriendsIc),
            title: Text(
              AppStrings.shareWithFrinds.tr(),
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            trailing: Transform(
              alignment: Alignment.center,
              transform: Matrix4.rotationY(isRtl() ? math.pi : 0),
              child: SvgPicture.asset(ImageAssets.settingsRightArrowIc),
            ),
            onTap: () {},
          ),
          ListTile(
            leading: SvgPicture.asset(ImageAssets.logoutIc),
            title: Text(
              AppStrings.logout.tr(),
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            onTap: () {
              // make user loggedout in app prefs
              _appPreferences.userLoggedout();
              // clear the user cache
              _localDataSource.clearCache();
              // navigate to login screen
              Navigator.of(context).pushReplacementNamed(Routes.loginRoute);
            },
          ),
        ],
      ),
    );
  }

  bool isRtl() {
    return context.locale == ARABIC_LOCALE;
  }

  _changeAppLang() {
    _appPreferences.changeAppLang();
    Phoenix.rebirth(context);
  }
}
