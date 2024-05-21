import 'package:base_example/pages/root.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'global.dart';

/// 根节点导航key
final GlobalKey<NavigatorState> rootNavigatorKey = GlobalKey<NavigatorState>();

/// 根节点context
BuildContext get rootContext => rootNavigatorKey.currentContext!;

void main() async {
  await initApp(rootNavigatorKey: rootNavigatorKey);
  Get.put(AppDataController());
  Get.put(GlobalController());
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    AppDataController c = Get.find();
    return Obx(() {
      return AppWidget(
        data: c.config.value,
        child: MaterialApp(
          navigatorKey: rootNavigatorKey,
          onGenerateTitle: (context) => S.of(context).title,
          themeMode: c.themeMode.value,
          theme: AppWidget.buildThemeData(data: c.config.value),
          darkTheme: AppWidget.buildThemeData(data: c.config.value, brightness: Brightness.dark),
          showPerformanceOverlay: GlobalController.of.showPerformanceOverlay.value,
          home: const RootPage(),
          localizationsDelegates: const [
            S.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: S.delegate.supportedLocales,
          builder: AppWidget.builder(
            (context, child) => Material(
              child: CupertinoTheme(
                data: AppWidget.buildCupertinoThemeData(data: c.config.value, brightness: context.theme.brightness),
                child: child!,
              ),
            ),
          ),
        ),
      );
    });
  }
}
