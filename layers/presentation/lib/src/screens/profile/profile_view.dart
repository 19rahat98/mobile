import 'package:application/application.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:presentation/src/routes/paths.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          ElevatedButton(
            onPressed: () {
              context.push(Paths.pin.path);
            },
            child: const Text('require lock'),
          ),
          ElevatedButton(
            onPressed: () {
              context.read<ProfileBloc>().logout();
            },
            child: const Text('logout'),
          ),
        ],
      ),
    );
  }
}
