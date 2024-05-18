import 'package:flutter/cupertino.dart';
import 'package:theme_example/global.dart';
import 'package:theme_example/state.dart';

import 'pages/home.dart';

/// 根节点导航key
final GlobalKey<NavigatorState> rootNavigatorKey = GlobalKey<NavigatorState>();

void main() async {
  await initApp(rootNavigatorKey: rootNavigatorKey);
  initController();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    AppController c = Get.find();
    return Obx(() {
      return AppWidget(
          data: c.config.value,
          child: ValueListenableBuilder(
            valueListenable: GlobalState.showPerformanceOverlay,
            builder: (context, value, child) {
              return Obx(() => MaterialApp(
                    navigatorKey: rootNavigatorKey,
                    debugShowCheckedModeBanner: false,
                    showPerformanceOverlay: value,
                    themeMode: c.themeMode.value,
                    theme: AppWidget.buildThemeData(data: c.config.value, brightness: Brightness.light),
                    darkTheme: AppWidget.buildThemeData(data: c.config.value, brightness: Brightness.dark),
                    home: const HomePage(),
                    builder: AppWidget.builder(
                      (context, child) => Material(
                        child: CupertinoTheme(
                          data: AppWidget.buildCupertinoThemeData(data: c.config.value, brightness: context.theme.brightness),
                          child: child!,
                        ),
                      ),
                    ),
                  ));
            },
          ));
    });
  }
}
