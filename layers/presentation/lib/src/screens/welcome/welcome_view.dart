import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:presentation/src/routes/paths.dart';

class WelcomeView extends StatelessWidget {
  const WelcomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          ElevatedButton(
            onPressed: () {
              context.push(Paths.welcome.login.path);
            },
            child: const Text('login'),
          ),
          ElevatedButton(
            onPressed: () {
              context.push(Paths.welcome.createAccount.path);
            },
            child: const Text('create account'),
          )
        ],
      ),
    );
  }
}
