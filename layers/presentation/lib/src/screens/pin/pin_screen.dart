import 'package:flutter/material.dart';

import 'pin_view.dart';

class PinScreen extends StatelessWidget {
  const PinScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('PIN'),
      ),
      body: const PinView(),
    );
  }
}
