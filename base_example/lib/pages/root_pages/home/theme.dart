import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

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
            _AppTheme(
              title: 'bgColor',
              color: context.appTheme.bgColor,
              colorPicker: _ColorPicker(
                color: context.appTheme.bgColor,
                onChange: (color) {
                  if (context.isDarkMode) {
                    AppDataController.of.darkTheme.value.bgColor = color;
                    AppDataController.of.darkTheme.refresh();
                  } else {
                    AppDataController.of.theme.value.bgColor = color;
                    AppDataController.of.darkTheme.refresh();
                  }
                },
              ),
            ),
            _AppTheme(
              title: 'headerColor',
              color: context.appTheme.headerColor,
              colorPicker: _ColorPicker(
                color: context.appTheme.headerColor,
                onChange: (color) {
                  if (context.isDarkMode) {
                    AppDataController.of.darkTheme.value.headerColor = color;
                    AppDataController.of.darkTheme.refresh();
                  } else {
                    AppDataController.of.theme.value.headerColor = color;
                    AppDataController.of.darkTheme.refresh();
                  }
                },
              ),
            ),
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
                    AppDataController.of.darkTheme.value = AppDataController.of.darkTheme.value.copyWith(primary: color);
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

class _AppTheme extends StatelessWidget {
  const _AppTheme({
    required this.title,
    required this.color,
    required this.colorPicker,
  });

  final String title;
  final Color color;

  final Widget colorPicker;

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.hardEdge,
      child: Column(
        children: [
          ListTile(
            onTap: () {
              showDialog(
                context: context,
                barrierColor: Colors.black12,
                builder: (context) => UnconstrainedBox(
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 280),
                    child: Material(
                      elevation: 2,
                      borderRadius: BorderRadius.circular(6),
                      child: colorPicker,
                    ),
                  ),
                ),
              );
            },
            title: Text(title),
            trailing: const Icon(Icons.keyboard_arrow_right),
          ),
          Row(
            children: [
              ...List.generate(
                5,
                (index) {
                  var $color = color.deepen(index * 5);
                  return Expanded(
                    child: AspectRatio(
                      aspectRatio: 1,
                      child: ColoredBox(
                        color: $color,
                        child: Center(
                          child: Text(
                            'bgColor${index == 0 ? '' : index + 1}',
                            style: TextStyle(
                              color: $color.isDark ? Colors.white : Colors.black,
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              )
            ],
          ),
        ],
      ),
    );
  }
}

class _ColorPicker extends StatelessWidget {
  const _ColorPicker({
    required this.color,
    required this.onChange,
  });

  final Color color;
  final void Function(Color color) onChange;

  @override
  Widget build(BuildContext context) {
    return ColorPicker(
      pickerColor: color,
      portraitOnly: true,
      colorPickerWidth: 280,
      pickerAreaHeightPercent: 0.7,
      enableAlpha: true,
      displayThumbColor: true,
      paletteType: PaletteType.hsvWithHue,
      pickerAreaBorderRadius: BorderRadius.circular(6),
      labelTypes: const [],
      onColorChanged: (Color color) {
        onChange(color);
      },
    );
  }
}
