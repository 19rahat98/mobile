import 'package:flutter/material.dart';

import 'pin_view.dart';

class PinScreen extends StatelessWidget {
  const PinScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('PIN'),
          leading: const SizedBox.shrink(),
        ),
        body: const PinView(),
      ),
      onWillPop: () async => false,
    );
  }
}
