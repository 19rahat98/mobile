import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:presentation/src/routes/paths.dart';

class SplittersView extends StatelessWidget {
  const SplittersView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: <Widget>[
          ElevatedButton(
            onPressed: () {
              context.push(Paths.home.splitters.create.path);
            },
            child: const Text('Create Splitter'),
          ),
        ],
      ),
    );
  }
}
