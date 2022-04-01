import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:presentation/src/routes/paths.dart';
import 'package:presentation/src/screens/feed/feed_screen.dart';
import 'package:presentation/src/screens/splitters/splitters_screen.dart';

class TabData {
  const TabData({
    required this.name,
  });

  final String name;
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key, required this.tabIndex}) : super(key: key);

  final int tabIndex;

  static Map<String, TabData> get tabs => {
        Paths.home.feed.path: const TabData(name: 'main'),
        Paths.home.splitters.path: const TabData(name: 'splitters'),
      };

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  late final TabController tabController;

  @override
  void initState() {
    super.initState();
    tabController = TabController(
      length: 2,
      vsync: this,
      initialIndex: widget.tabIndex,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('HOME'),
      ),
      body: TabBarView(
        controller: tabController,
        children: const [
          FeedScreen(),
          SplittersScreen(),
        ],
      ),
      bottomNavigationBar: SafeArea(
        child: TabBar(
          controller: tabController,
          onTap: (index) {
            context.go(HomeScreen.tabs.keys.elementAt(index));
          },
          tabs: const [
            Tab(text: 'Main'),
            Tab(text: 'Splitters'),
          ],
        ),
      ),
    );
  }
}
