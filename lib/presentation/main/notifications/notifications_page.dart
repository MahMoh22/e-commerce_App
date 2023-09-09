import 'package:flutter/material.dart';

class NotifificationsPage extends StatefulWidget {
  const NotifificationsPage({super.key});

  @override
  State<NotifificationsPage> createState() => _NotifificationsPageState();
}

class _NotifificationsPageState extends State<NotifificationsPage> {
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text("notifications"),
    );
  }
}
