import 'package:styled_widget/styled_widget.dart';
import 'package:theme_example/global.dart';

import '../widgets/button.dart';
import '../widgets/home_action.dart';
import '../widgets/input.dart';

class HomePage extends HookWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return HideKeyboardWidget(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('首页'),
          actions: [
            IconButton(
              onPressed: () {
                AppController.of.themeMode.value = context.isDarkMode ? ThemeMode.light : ThemeMode.dark;
              },
              icon: Icon(context.isDarkMode ? Icons.dark_mode : Icons.light_mode),
            ),
            Obx(
              () => IconButton(
                onPressed: () {
                  AppController.of.config.value.useMaterial3 = !AppController.of.config.value.useMaterial3;
                  AppController.of.config.refresh();
                },
                icon: Icon(
                  AppController.of.config.value.useMaterial3 ? Icons.looks_3_outlined : Icons.looks_two_outlined,
                ),
              ),
            ),
            const SwitchThemeButton(),
          ],
        ),
        body: buildScrollWidget(
          child: buildCenterColumn([
            Obx(() {
              return ElevatedButton(
                onPressed: () {
                  AppController.of.themeMode.value =
                      AppController.of.themeMode.value == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
                },
                child: Text(AppController.of.themeMode.value.toString()),
              );
            }),
            const Icon(Icons.home),
            const SwitchThemeButton(),
            const ButtonWidgets(),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Switch(value: false, onChanged: (v) {}),
                Switch(value: true, onChanged: (v) {}),
              ],
            ),
            Column(
              children: inputWidgets,
            ).padding(all: 16),
            buildCardWidget(context, title: '卡片', children: [
              buildCellWidget(context, title: 'Button 按钮'),
              buildCellWidget(context, title: 'Switch 开关'),
            ]),
            ...List.generate(20, (index) => buildCellWidget(context, title: '列表 - ${index + 1}')),
          ]),
        ),
      ),
    );
  }
}
