import 'package:flutter/material.dart';

mixin ScrollToFetchMixin<T extends StatefulWidget> on State<T> {
  int scrollThreshold = 100;
  late final ScrollController scrollController;

  bool _hasSetUpScrollListener = false;

  @override
  void initState() {
    super.initState();
    scrollController = ScrollController();
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  void setUpScrollToFetch(void Function() onScrollToFetch) {
    if (_hasSetUpScrollListener) {
      return;
    }

    _hasSetUpScrollListener = true;

    scrollController.addListener(() {
      final max = scrollController.position.maxScrollExtent;
      final current = scrollController.position.pixels;

      if (current > (max - scrollThreshold)) {
        onScrollToFetch();
      }
    });
  }
}
