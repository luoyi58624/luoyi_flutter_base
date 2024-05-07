import 'package:base_example/pages/all_color.dart';
import 'package:base_example/pages/color.dart';
import 'package:base_example/pages/hook.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:luoyi_flutter_base/luoyi_flutter_base.dart';

import '../widgets/button.dart';
import 'button.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int count = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('首页'),
        actions: [
          Obx(
            () => Switch(
              value: AppDataController.of.config.value.useMaterial3,
              onChanged: (v) {
                AppDataController.of.config.value = AppDataController.of.config.value.copyWith(useMaterial3: v);
              },
            ),
          ),
        ],
      ),
      body: Center(
        child: Column(
          children: [
            const SizedBox(height: 8),
            ButtonWidget(
              onPressed: () {
                context.push(const ButtonTestPage());
              },
              child: const Text('button测试页面'),
            ),
            const SizedBox(height: 8),
            ButtonWidget(
              onPressed: () {
                context.push(const HookTestPage());
              },
              child: const Text('hook测试页面'),
            ),
            const SizedBox(height: 8),
            ButtonWidget(
              onPressed: () {
                context.push(const ColorTestPage());
              },
              child: const Text('color测试页面'),
            ),
            const SizedBox(height: 8),
            ButtonWidget(
              onPressed: () {
                context.push(const AllColorTestPage());
              },
              child: const Text('all color测试页面'),
            ),
            const SizedBox(height: 8),
            // TapBuilder(builder: (isTap) {
            //   return HoverBuilder(builder: (isHover) {
            //     return Container(
            //       width: 100,
            //       height: 100,
            //       color: context.flutterTheme.primary.onTap(context, isTap).onHover(context, isHover),
            //     );
            //   });
            // }),
            // const SizedBox(height: 8),
            // TapBuilder(
            //   onTap: () {
            //     setState(() {
            //       count++;
            //     });
            //   },
            //   builder: (isTap) {
            //     i(isTap);
            //     return Container(
            //       width: 100,
            //       height: 36,
            //       decoration: BoxDecoration(
            //         borderRadius: BorderRadius.circular(6),
            //         color: context.flutterTheme.primary.onTap(context, isTap),
            //       ),
            //       child: Text('count: $count'),
            //     );
            //   },
            // ),
            // Container(
            //   width: 100,
            //   height: 100,
            //   color: FlutterTheme.theme(context).primary,
            //   child: Text('primary: ${FlutterTheme.theme(context).primary}'),
            // ),
            // Obx(() {
            //   return Container(
            //     width: 100,
            //     height: 100,
            //     color: themeController.darkTheme.primary,
            //   );
            // }),
            // Obx(() {
            //   return Container(
            //     width: 100,
            //     height: 100,
            //     color: themeController.theme.customColor,
            //   );
            // }),
            // Container(
            //   width: 100,
            //   height: 100,
            //   color: FlutterTheme.flutterTheme(context).primary,
            // ),
            // Obx(() {
            //   return Container(
            //     width: 100,
            //     height: 100,
            //     color: themeController.flutterTheme(context).customColor,
            //   );
            // }),
          ],
        ),
      ),
    );
  }
}

class CupertinoHomePage extends StatelessWidget {
  const CupertinoHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    i(Theme.of(context).extension<FlutterThemeData>());
    i(context.isDarkMode);
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        middle: Text('首页'),
      ),
      child: SafeArea(
        child: Center(
          child: Column(
            children: [
              CupertinoButton.filled(
                onPressed: () {
                  Navigator.of(context).push(
                    CupertinoPageRoute(builder: (context) => const DemoPage()),
                  );
                },
                child: Text('Hello: ${CupertinoTheme.of(context).brightness}'),
              ),
              const SizedBox(height: 8),
              Container(
                width: 100,
                height: 100,
                color: context.currentThemeData.primary,
                child: Text('Hello: ${context.currentThemeData.primary}'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ChildPage extends StatelessWidget {
  const ChildPage({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        middle: Text('子页面'),
        previousPageTitle: '首页',
      ),
      child: Center(
        child: CupertinoButton.filled(
          onPressed: () {
            Navigator.of(context).push(
              CupertinoPageRoute(builder: (context) => const ChildPage()),
            );
          },
          child: Text('Hello: ${CupertinoTheme.of(context).brightness}'),
        ),
      ),
    );
  }
}

class DemoPage extends StatelessWidget {
  const DemoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
