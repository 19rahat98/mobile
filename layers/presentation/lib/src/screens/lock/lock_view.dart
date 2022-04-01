import 'package:application/application.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LockView extends StatelessWidget {
  const LockView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: <Widget>[
          ElevatedButton(
            onPressed: () {
              context.read<AuthBloc>().unlock();
            },
            child: const Text('unlock'),
          ),
          ElevatedButton(
            onPressed: () {
              context.read<ProfileBloc>().logout();
            },
            child: const Text('logout'),
          )
        ],
      ),
    );
  }
}
