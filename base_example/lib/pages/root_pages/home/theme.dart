import 'package:flutter/material.dart';

import '../../../global.dart';

class ThemePage extends StatefulWidget {
  const ThemePage({super.key});

  @override
  State<ThemePage> createState() => _ThemePageState();
}

class _ThemePageState extends State<ThemePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('App主题设置'),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(children: [
            buildCell(),
            buildLightPrimaryTheme(),
            buildDarkPrimaryTheme(),
          ]),
        ),
      ),
    );
  }

  Widget buildCell() {
    return Card(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            title: const Text('开启性能监控'),
            trailing: Obx(
              () => Switch(
                value: GlobalController.of.showPerformanceOverlay.value,
                onChanged: (v) {
                  GlobalController.of.showPerformanceOverlay.value = v;
                },
              ),
            ),
          ),
          ListTile(
            onTap: () {
              AppDataController.of.themeMode.value = ThemeMode.system;
            },
            title: const Text('跟随系统'),
            trailing: Obx(
              () => Radio<ThemeMode>(
                value: AppDataController.of.themeMode.value,
                onChanged: (ThemeMode? mode) {
                  AppDataController.of.themeMode.value = ThemeMode.system;
                },
                groupValue: ThemeMode.system,
              ),
            ),
          ),
          ListTile(
            onTap: () {
              AppDataController.of.themeMode.value = ThemeMode.light;
            },
            title: const Text('亮色模式'),
            trailing: Obx(
              () => Radio<ThemeMode>(
                value: AppDataController.of.themeMode.value,
                onChanged: (ThemeMode? mode) {
                  AppDataController.of.themeMode.value = ThemeMode.light;
                },
                groupValue: ThemeMode.light,
              ),
            ),
          ),
          ListTile(
            onTap: () {
              AppDataController.of.themeMode.value = ThemeMode.dark;
            },
            title: const Text('黑暗模式'),
            trailing: Obx(
              () => Radio<ThemeMode>(
                value: AppDataController.of.themeMode.value,
                onChanged: (ThemeMode? mode) {
                  AppDataController.of.themeMode.value = ThemeMode.dark;
                },
                groupValue: ThemeMode.dark,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildLightPrimaryTheme() {
    return Card(
      clipBehavior: Clip.hardEdge,
      child: ExpansionTile(
        leading: const Icon(Icons.color_lens),
        title: const Text('亮色主题颜色'),
        initiallyExpanded: true,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Wrap(
              spacing: 8,
              runSpacing: 8,
              children: FlutterColorData.materialColors.values.map((color) {
                return InkWell(
                  onTap: () {
                    AppDataController.of.theme.value = AppDataController.of.theme.value.copyWith(primary: color);
                  },
                  child: Obx(
                    () => Container(
                      width: 40,
                      height: 40,
                      color: color,
                      child: AppDataController.of.theme.value.primary == color
                          ? const Icon(
                              Icons.done,
                              color: Colors.white,
                            )
                          : null,
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildDarkPrimaryTheme() {
    return Card(
      clipBehavior: Clip.hardEdge,
      child: ExpansionTile(
        leading: const Icon(Icons.color_lens),
        title: const Text('暗色主题颜色'),
        initiallyExpanded: true,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Wrap(
              spacing: 8,
              runSpacing: 8,
              children: FlutterColorData.materialColors.values.map((color) {
                return InkWell(
                  onTap: () {
                    AppDataController.of.darkTheme.value =
                        AppDataController.of.darkTheme.value.copyWith(primary: color);
                  },
                  child: Obx(
                    () => Container(
                      width: 40,
                      height: 40,
                      color: color,
                      child: AppDataController.of.darkTheme.value.primary == color
                          ? const Icon(
                              Icons.done,
                              color: Colors.white,
                            )
                          : null,
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}
