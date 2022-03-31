import 'package:flutter/material.dart';

import 'create_account_view.dart';

class CreateAccountScreen extends StatelessWidget {
  const CreateAccountScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('CREATE ACCOUNT'),
      ),
      body: const CreateAccountView(),
    );
  }
}
