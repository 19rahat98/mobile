import 'package:flutter/material.dart';

import 'create_splitter_view.dart';

class CreateSplitterScreen extends StatelessWidget {
  const CreateSplitterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('CREATE_SPLITTER'),
      ),
      body: const CreateSplitterView(),
    );
  }
}
