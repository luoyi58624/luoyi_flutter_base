import 'package:base_example/extensions/context.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

import '../../../global.dart';

class ThemePage2 extends StatefulWidget {
  const ThemePage2({super.key});

  @override
  State<ThemePage2> createState() => _ThemePage2State();
}

class _ThemePage2State extends State<ThemePage2> {
  int count = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('App主题设置'),
      ),
      body: buildScrollWidget(
        child: Center(
          child: Column(children: [
            buildDarkCell(),
            buildConfigCell(),
            buildM2ConfigCell(),
            buildM3ConfigCell(),
            buildBaseThemeCell(context),
            _LayoutTheme(
              title: 'bgColor',
              color: context.appTheme.bgColor,
              colors: context.appTheme.bgColors,
              colorPicker: _ColorPicker(
                color: context.appTheme.bgColor,
                onChange: (color) {
                  // count++;
                  // i(count);
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
            _LayoutTheme(
              title: 'headerColor',
              color: context.appTheme.headerColor,
              colors: context.appTheme.headerColors,
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
            _LayoutTheme(
              title: 'textColor',
              color: context.appTheme.textColor,
              colors: context.appTheme.textColors,
              colorPicker: _ColorPicker(
                color: context.appTheme.textColor,
                onChange: (color) {
                  if (context.isDarkMode) {
                    AppDataController.of.darkTheme.value.textColor = color;
                    AppDataController.of.darkTheme.refresh();
                  } else {
                    AppDataController.of.theme.value.textColor = color;
                    AppDataController.of.darkTheme.refresh();
                  }
                },
              ),
            ),
            _LayoutTheme(
              title: 'iconColor',
              color: context.appTheme.iconColor,
              colors: context.appTheme.iconColors,
              colorPicker: _ColorPicker(
                color: context.appTheme.iconColor,
                onChange: (color) {
                  if (context.isDarkMode) {
                    AppDataController.of.darkTheme.value.iconColor = color;
                    AppDataController.of.darkTheme.refresh();
                  } else {
                    AppDataController.of.theme.value.iconColor = color;
                    AppDataController.of.darkTheme.refresh();
                  }
                },
              ),
            ),
            buildLightPrimaryTheme(),
            buildDarkPrimaryTheme(),
          ]),
        ),
      ),
    );
  }

  Widget buildDarkCell() {
    return Card(
      clipBehavior: Clip.hardEdge,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
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

  Widget buildConfigCell() {
    return Card(
      clipBehavior: Clip.hardEdge,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            onTap: () {
              GlobalController.of.showPerformanceOverlay.value = !GlobalController.of.showPerformanceOverlay.value;
            },
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
            title: const Text('开启M3'),
            trailing: Obx(
              () => Switch(
                value: AppDataController.of.config.value.useMaterial3,
                onChanged: (v) {
                  AppDataController.of.config.value = AppDataController.of.config.value.copyWith(useMaterial3: v);
                },
              ),
            ),
          ),
          ListTile(
            title: const Text('M2开启半透明状态栏'),
            trailing: Obx(
              () => Switch(
                value: AppDataController.of.config.value.m2Config.translucenceStatusBar,
                onChanged: (v) {
                  AppDataController.of.config.value.m2Config.translucenceStatusBar = v;
                  AppDataController.of.config.refresh();
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildM2ConfigCell() {
    return Card(
      clipBehavior: Clip.hardEdge,
      child: ExpansionTile(
        leading: const Icon(Icons.looks_two_outlined),
        title: const Text('M2配置'),
        initiallyExpanded: true,
        children: [
          buildListTileWidget(
            context,
            onTap: () {
              AppDataController.of.config.value.m2Config = M2ConfigData.config;
              AppDataController.of.config.refresh();
            },
            title: '加载 M2 默认配置',
          ),
          buildListTileWidget(
            context,
            onTap: () {
              AppDataController.of.config.value.m2Config = M2ConfigData.customConfig;
              AppDataController.of.config.refresh();
            },
            title: '加载 M2 自定义配置',
          ),
        ],
      ),
    );
  }

  Widget buildM3ConfigCell() {
    return Card(
        clipBehavior: Clip.hardEdge,
        child: ExpansionTile(
          leading: const Icon(Icons.looks_3_outlined),
          title: const Text('M3配置'),
          initiallyExpanded: true,
          children: [
            buildListTileWidget(
              context,
              onTap: () {
                AppDataController.of.config.value.m3Config = M3ConfigData.config;
                AppDataController.of.config.refresh();
              },
              title: '加载 M3 默认配置',
            ),
            buildListTileWidget(
              context,
              onTap: () {
                AppDataController.of.config.value.m3Config = M3ConfigData.customConfig;
                AppDataController.of.config.refresh();
              },
              title: '加载 M3 自定义配置',
            ),
          ],
        ));
  }

  Widget buildBaseThemeCell(BuildContext context) {
    return Card(
      clipBehavior: Clip.hardEdge,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            onTap: () async {
              Color? color = await context.showColorPicker(context.appTheme.primary);
              if (color != null) {
                if (context.mounted) {
                  AppDataController.of.setTheme(context, context.appTheme.copyWith(primary: color));
                }
              }
            },
            title: const Text('Primary'),
            trailing: buildBoxWidget(color: context.appTheme.primary),
          ),
          ListTile(
            onTap: () async {
              Color? color = await context.showColorPicker(context.appTheme.success);
              if (color != null) {
                if (context.mounted) {
                  AppDataController.of.setTheme(context, context.appTheme.copyWith(success: color));
                }
              }
            },
            title: const Text('Success'),
            trailing: buildBoxWidget(color: context.appTheme.success),
          ),
          ListTile(
            onTap: () async {
              Color? color = await context.showColorPicker(context.appTheme.info);
              if (color != null) {
                if (context.mounted) {
                  AppDataController.of.setTheme(context, context.appTheme.copyWith(info: color));
                }
              }
            },
            title: const Text('Info'),
            trailing: buildBoxWidget(color: context.appTheme.info),
          ),
          ListTile(
            onTap: () async {
              Color? color = await context.showColorPicker(context.appTheme.warning);
              if (color != null) {
                if (context.mounted) {
                  AppDataController.of.setTheme(context, context.appTheme.copyWith(warning: color));
                }
              }
            },
            title: const Text('Warning'),
            trailing: buildBoxWidget(color: context.appTheme.warning),
          ),
          ListTile(
            onTap: () async {
              Color? color = await context.showColorPicker(context.appTheme.error);
              if (color != null) {
                if (context.mounted) {
                  AppDataController.of.setTheme(context, context.appTheme.copyWith(error: color));
                }
              }
            },
            title: const Text('Error'),
            trailing: buildBoxWidget(color: context.appTheme.error),
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

class _LayoutTheme extends StatelessWidget {
  const _LayoutTheme({
    required this.title,
    required this.color,
    required this.colors,
    required this.colorPicker,
  });

  final String title;
  final Color color;
  final List<Color> colors;

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
            tileColor: color,
            title: Text(
              '$title - ${color.toHex()}',
              style: TextStyle(
                color: color.isDark ? Colors.white : Colors.black,
              ),
            ),
            trailing: const Icon(Icons.keyboard_arrow_right),
          ),
          Row(
            children: [
              ...colors.mapIndexed((index, $color) {
                return Expanded(
                  child: AspectRatio(
                    aspectRatio: 1,
                    child: ColoredBox(
                      color: $color,
                      child: Center(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              '$title${index + 1}',
                              style: TextStyle(
                                color: $color.isDark ? Colors.white : Colors.black,
                              ),
                            ),
                            Text(
                              $color.toHex(),
                              style: TextStyle(
                                color: $color.isDark ? Colors.white : Colors.black,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              }),
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
