import 'package:flutter/material.dart';

import 'allow_notifications_view.dart';

class AllowNotificationsScreen extends StatelessWidget {
  const AllowNotificationsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ALLOW_NOTIFICATIONS'),
      ),
      body: const AllowNotificationsView(),
    );
  }
}
