import 'package:e_commerce_app/presentation/main/home/home_page.dart';
import 'package:e_commerce_app/presentation/main/notifications/notifications_page.dart';
import 'package:e_commerce_app/presentation/main/search/search_page.dart';
import 'package:e_commerce_app/presentation/main/settings/setting_page.dart';
import 'package:e_commerce_app/presentation/resources/color_manager.dart';
import 'package:e_commerce_app/presentation/resources/strings_manager.dart';
import 'package:e_commerce_app/presentation/resources/theme_manager.dart';
import 'package:e_commerce_app/presentation/resources/values_manager.dart';
import 'package:flutter/material.dart';

class MainView extends StatefulWidget {
  const MainView({super.key});

  @override
  State<MainView> createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  List<Widget> pages = [
    const HomePage(),
    const SearchPage(),
    const NotifificationsPage(),
    const SettingsPage()
  ];
  List<String> titles = [
    AppStrings.home,
    AppStrings.search,
    AppStrings.notifications,
    AppStrings.settings
  ];
  var _title = "Home";
  var _currentIndix = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          _title,
          style: Theme.of(context).textTheme.titleLarge,
        ),
      ),
      body: pages[_currentIndix],
      bottomNavigationBar: Container(
        decoration: BoxDecoration(boxShadow: [
          BoxShadow(color: ColorManager.lightGray, spreadRadius: AppSizes.s1)
        ]),
        child: BottomNavigationBar(
            selectedItemColor: ColorManager.primary,
            unselectedItemColor: ColorManager.gray,
            currentIndex: _currentIndix,
            onTap: onTape,
            items: const [
              BottomNavigationBarItem(
                  icon: Icon(Icons.home_outlined), label: AppStrings.home),
              BottomNavigationBarItem(
                  icon: Icon(Icons.search), label: AppStrings.search),
              BottomNavigationBarItem(
                  icon: Icon(Icons.notifications_none),
                  label: AppStrings.notifications),
              BottomNavigationBarItem(
                  icon: Icon(Icons.settings), label: AppStrings.settings),
            ]),
      ),
    );
  }

  onTape(int index) {
    setState(() {
      _currentIndix = index;
      _title = titles[index];
    });
  }
}
