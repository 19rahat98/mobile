import 'package:flutter/material.dart';

import 'home_view.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen(this.tab, {Key? key}) : super(key: key);

  final String tab;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('HOME'),
      ),
      body: const HomeView(),
    );
  }
}
