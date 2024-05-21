import 'package:theme_example/global.dart';
import 'package:theme_example/pages/hook.dart';
import 'package:theme_example/pages/loading.dart';
import 'package:theme_example/pages/route.dart';
import 'package:theme_example/state.dart';

import '../widgets/tab.dart';
import '../widgets/button.dart';
import '../widgets/cupertino.dart';
import '../widgets/home_action.dart';
import '../widgets/form.dart';

class HomePage extends HookWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return HideKeyboardWidget(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('首页'),
          centerTitle: false,
          actions: [
            ValueListenableBuilder(
              valueListenable: GlobalState.showPerformanceOverlay,
              builder: (context, value, child) {
                return Switch(
                  value: value,
                  onChanged: (v) => GlobalState.showPerformanceOverlay.value = v,
                );
              },
            ),
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
        drawer: Drawer(
          child: buildListViewDemo(itemCount: 10000),
        ),
        body: buildScrollWidget(
          child: buildCenterColumn([
            const Gap(8),
            const ButtonWidgets(),
            const FormWidgets(),
            const TabWidget(),
            buildCardWidget(context, title: '卡片', children: [
              buildCellWidget(context, title: 'Loading 页面', page: const LoadingPage()),
              buildCellWidget(context, title: 'Hook 页面', page: const HookDemoPage()),
              buildCellWidget(context, title: 'Route 页面', page: const RoutePage()),
              buildCellWidget(context, title: '显示 Toast', onTap: () {
                ToastUtil.show('hello，你好');
              }),
              buildCellWidget(context, title: '显示提示框', onTap: () {
                context.showConfirmModal(content: '这是一段文字');
              }),
            ]),
            const CupertinoWidgets(),
            ...List.generate(20, (index) => buildCellWidget(context, title: '列表 - ${index + 1}')),
          ]),
        ),
      ),
    );
  }
}
