import 'package:flutter/material.dart';

import 'forgot_password_view.dart';

class ForgotPasswordScreen extends StatelessWidget {
  const ForgotPasswordScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('FORGOT PASSWORD'),
      ),
      body: const ForgotPasswordView(),
    );
  }
}
