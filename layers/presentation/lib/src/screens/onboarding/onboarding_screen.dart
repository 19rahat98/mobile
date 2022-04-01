import 'package:flutter/material.dart';

import 'onboarding_view.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ONBOARDING'),
      ),
      body: const OnboardingView(),
    );
  }
}
