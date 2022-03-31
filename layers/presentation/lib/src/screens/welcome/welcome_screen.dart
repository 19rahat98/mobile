import 'package:flutter/material.dart';

import 'welcome_view.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('WELCOME'),
      ),
      body: const WelcomeView(),
    );
  }
}
