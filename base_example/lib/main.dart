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
    return Obx(() {
      return AppWidget(
        data: AppDataController.of.config.value,
        child: materialApp(),
      );
    });
  }

  Widget materialApp() {
    return Builder(builder: (context) {
      return Obx(() {
        return MaterialApp(
          navigatorKey: rootNavigatorKey,
          onGenerateTitle: (context) => S.of(context).title,
          themeMode: AppDataController.of.themeMode.value,
          theme: AppWidget.buildThemeData(context),
          darkTheme: AppWidget.buildThemeData(context, brightness: Brightness.dark),
          showPerformanceOverlay: GlobalController.of.showPerformanceOverlay.value,
          home: const RootPage(),
          localizationsDelegates: const [
            S.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: S.delegate.supportedLocales,
          builder: ToastUtil.builder(
            (context, child) => Material(
              child: CupertinoTheme(
                data: AppWidget.buildCupertinoThemeData(context, brightness: context.theme.brightness),
                child: child!,
              ),
            ),
          ),
        );
      });
    });
  }
}
