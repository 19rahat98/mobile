import 'package:flutter/material.dart';

import 'feed_view.dart';

class FeedScreen extends StatelessWidget {
  const FeedScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('FEED'),
      ),
      body: const FeedView(),
    );
  }
}
