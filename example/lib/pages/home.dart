import 'package:flutter/material.dart';
import 'package:example/global.dart';

import '../widgets/tab.dart';
import '../widgets/button.dart';
import '../widgets/cupertino.dart';
import '../widgets/form.dart';
import 'hook.dart';

class HomePage extends HookWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('首页'),
        centerTitle: false,
        actions: _buildActions(context),
      ),
      drawer: const Drawer(
        child: ListViewDemoWidget(),
      ),
      body: SingleChildScrollView(
        child: ColumnWidget(children: [
          buildCardWidget(context, title: '通用组件', children: [
            buildCellWidget(context,
                title: 'Hook 测试', page: const HookDemoPage()),
          ]),
          TapBuilder(
            onTap: () {},
            builder: (isTap) => Container(
              width: 100,
              height: 100,
              color: Colors.grey.onTap(isTap),
            ),
          ),
          const Gap(8),
          const ButtonWidgets(),
          const FormWidgets(),
          const TabWidget(),
          const CupertinoWidgets(),
          ...List.generate(20,
              (index) => buildCellWidget(context, title: '列表 - ${index + 1}')),
        ]),
      ),
    );
  }
}

List<Widget> _buildActions(BuildContext context) => [
      IconButton(
        onPressed: () {
          AppController.of.themeMode.value =
              context.isDark ? ThemeMode.light : ThemeMode.dark;
        },
        icon: Icon(context.isDark ? Icons.dark_mode : Icons.light_mode),
      ),
    ];
