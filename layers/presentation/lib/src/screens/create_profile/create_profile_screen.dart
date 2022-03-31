import 'package:flutter/material.dart';

import 'create_profile_view.dart';

class CreateProfileScreen extends StatelessWidget {
  const CreateProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('CREATE_PROFILE'),
      ),
      body: const CreateProfileView(),
    );
  }
}
