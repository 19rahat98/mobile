import 'package:application/application.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:presentation/src/routes/paths.dart';

class LoginView extends StatelessWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          ElevatedButton(
            onPressed: () {
              context.read<AuthBloc>().signIn(needsOnboarding: true);
            },
            child: const Text('login (require onboarding)'),
          ),
          ElevatedButton(
            onPressed: () {
              context.read<AuthBloc>().signIn(needsOnboarding: false);
            },
            child: const Text('login (bypass onboarding)'),
          ),
          ElevatedButton(
            onPressed: () {
              context.push(Paths.welcome.forgotPassword.path);
            },
            child: const Text('forgot password'),
          )
        ],
      ),
    );
  }
}
