import 'package:base_example/pages/all_color.dart';
import 'package:base_example/pages/color.dart';
import 'package:base_example/pages/hook.dart';
import 'package:base_example/pages/root_pages/home/font.dart';
import 'package:base_example/pages/root_pages/home/local_obs.dart';
import 'package:base_example/pages/root_pages/home/theme.dart';
import 'package:base_example/pages/root_pages/home/toast.dart';
import 'package:flutter/material.dart';

import 'package:base_example/global.dart';
import '../../../widgets/button.dart';
import '../../button.dart';
import 'hook.dart';
import 'theme2.dart';

class HomeRootPage extends StatefulWidget {
  const HomeRootPage({super.key});

  @override
  State<HomeRootPage> createState() => _HomeRootPageState();
}

class _HomeRootPageState extends State<HomeRootPage> {
  int count = 0;
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).bottomLabelHome),
        actions: [
          IconButton(
            onPressed: () {
              AppDataController.of.themeMode.value = context.isDarkMode ? ThemeMode.light : ThemeMode.dark;
            },
            icon: Icon(context.isDarkMode ? Icons.dark_mode : Icons.light_mode),
          ),
          Obx(
            () => IconButton(
              onPressed: () {
                AppDataController.of.config.value = AppDataController.of.config.value
                    .copyWith(useMaterial3: !(AppDataController.of.config.value.useMaterial3));
              },
              icon: Icon(
                  AppDataController.of.config.value.useMaterial3 ? Icons.looks_3_outlined : Icons.looks_two_outlined),
            ),
          ),
          PopupMenuButton<String>(
            enableFeedback: true,
            offset: Offset(0, context.appbarHeight + 4),
            popUpAnimationStyle: AnimationStyle.noAnimation,
            icon: const Icon(Icons.translate),
            onSelected: (value) {
              S.load(Locale(value));
              FlutterUtil.refreshApp();
            },
            itemBuilder: (context) {
              return GlobalController.of.locale.keys
                  .map((key) => PopupMenuItem(
                        height: 40,
                        value: GlobalController.of.locale[key]!,
                        child: Text(key),
                      ))
                  .toList();
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              buildListTileWidget(context, title: '动态字体', page: DynamicFontPage()),
              buildListTileWidget(context, title: '主题设置', page: const ThemePage()),
              buildListTileWidget(context, title: '主题设置2', page: const ThemePage2()),
              buildListTileWidget(context, title: '本地响应式变量', page: const LocalObsPage()),
              buildListTileWidget(context, title: 'Hook测试', page: const HookPage()),
              buildListTileWidget(context, title: 'Toast测试', page: const ToastPage()),
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
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.push(const ThemePage());
        },
        child: const Icon(Icons.color_lens),
      ),
    );
  }
}
