import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:presentation/src/routes/paths.dart';

class OnboardingView extends StatelessWidget {
  const OnboardingView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: <Widget>[
          ElevatedButton(
            onPressed: () {
              context.push(Paths.onboarding.account.path);
            },
            child: const Text('Lets get started!'),
          )
        ],
      ),
    );
  }
}
