import 'package:e_commerce_app/presentation/resources/strings_manager.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class NotifificationsPage extends StatefulWidget {
  const NotifificationsPage({super.key});

  @override
  State<NotifificationsPage> createState() => _NotifificationsPageState();
}

class _NotifificationsPageState extends State<NotifificationsPage> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(AppStrings.notifications.tr()),
    );
  }
}
