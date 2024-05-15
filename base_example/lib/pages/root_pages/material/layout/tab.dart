import 'package:base_example/global.dart';
import 'package:flutter/material.dart';

class TabPage extends HookWidget {
  const TabPage({super.key});

  @override
  Widget build(BuildContext context) {
    final tabController = useTabController(initialLength: 3);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tab标签导航'),
        bottom: TabBar(
          controller: tabController,
          indicatorPadding: const EdgeInsets.symmetric(horizontal: -8),
          indicatorSize: TabBarIndicatorSize.label,
          labelStyle: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
          tabs: ['tab1', 'tab2', 'tab3'].map((e) => Tab(text: e)).toList(),
        ),
      ),
      body: ExtendedTabBarView(
        controller: tabController,
        shouldIgnorePointerWhenScrolling: false,
        cacheExtent: 3,
        children: [
          buildListViewDemo(),
          buildListViewDemo(),
          buildListViewDemo(),
        ],
      ),
    );
  }
}
