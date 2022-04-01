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
              context.read<ProfileBloc>().login('email', 'password');
            },
            child: const Text('login'),
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
