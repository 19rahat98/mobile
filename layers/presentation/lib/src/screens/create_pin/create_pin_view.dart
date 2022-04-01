import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:presentation/src/routes/paths.dart';

class CreatePinView extends StatelessWidget {
  const CreatePinView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: <Widget>[
          ElevatedButton(
            onPressed: () {
              context.push(Paths.onboarding.allowNotification.path);
            },
            child: const Text('Create, Next!'),
          )
        ],
      ),
    );
  }
}
