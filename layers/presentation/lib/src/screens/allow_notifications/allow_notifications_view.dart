import 'package:application/application.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AllowNotificationsView extends StatelessWidget {
  const AllowNotificationsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: <Widget>[
          ElevatedButton(
            onPressed: () {
              context.read<AuthBloc>().authenticate(needsOnboarding: false);
            },
            child: const Text('Finish!'),
          )
        ],
      ),
    );
  }
}
