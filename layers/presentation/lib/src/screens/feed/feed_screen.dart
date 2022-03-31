import 'package:flutter/material.dart';

import 'feed_view.dart';

class FeedScreen extends StatelessWidget {
  const FeedScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: FeedView(),
    );
  }
}
