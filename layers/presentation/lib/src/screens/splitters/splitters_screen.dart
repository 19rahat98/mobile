import 'package:flutter/material.dart';

import 'splitters_view.dart';

class SplittersScreen extends StatelessWidget {
  const SplittersScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('SPLITTERS'),
      ),
      body: const SplittersView(),
    );
  }
}
