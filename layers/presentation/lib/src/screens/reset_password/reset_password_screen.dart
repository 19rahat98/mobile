import 'package:flutter/material.dart';

import 'reset_password_view.dart';

class ResetPasswordScreen extends StatelessWidget {
  const ResetPasswordScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('RESET_PASSWORD'),
      ),
      body: const ResetPasswordView(),
    );
  }
}
