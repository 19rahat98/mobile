import 'package:application/application.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class PinView extends StatelessWidget {
  const PinView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: <Widget>[
          ElevatedButton(
            onPressed: () {
              context.pop();
            },
            child: const Text('success'),
          ),
          ElevatedButton(
            onPressed: () {
              context.read<AuthBloc>().lock();
            },
            child: const Text('failure'),
          ),
        ],
      ),
    );
  }
}
