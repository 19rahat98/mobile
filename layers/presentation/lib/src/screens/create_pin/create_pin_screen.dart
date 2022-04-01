import 'package:flutter/material.dart';

import 'create_pin_view.dart';

class CreatePinScreen extends StatelessWidget {
  const CreatePinScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('CREATE_PIN'),
      ),
      body: const CreatePinView(),
    );
  }
}
