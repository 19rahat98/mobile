import 'package:flutter/material.dart';

import 'lock_view.dart';

class LockScreen extends StatelessWidget {
  const LockScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('LOCK'),
      ),
      body: const LockView(),
    );
  }
}
