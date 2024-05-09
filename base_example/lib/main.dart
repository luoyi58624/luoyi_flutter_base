import 'package:base_example/pages/root.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'global.dart';

void main() async {
  await initApp();
  Get.put(AppDataController(config: FlutterConfigData()));
  // Get.put(AppDataController(config: FlutterConfigData(fontFamily: 'NotoSansSC')));
  Get.put(GlobalController());
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return AppData(
        theme: AppDataController.of.theme.value,
        darkTheme: AppDataController.of.darkTheme.value,
        config: AppDataController.of.config.value,
        child: materialApp(),
      );
    });
  }

  Widget materialApp() {
    return Builder(builder: (context) {
      return Obx(() {
        return MaterialApp(
          onGenerateTitle: (context) => S.of(context).title,
          themeMode: AppDataController.of.themeMode.value,
          theme: ThemeDataUtil.buildThemeData(context, Brightness.light),
          darkTheme: ThemeDataUtil.buildThemeData(context, Brightness.dark),
          showPerformanceOverlay: GlobalController.of.showPerformanceOverlay.value,
          home: const RootPage(),
          localizationsDelegates: const [
            S.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: S.delegate.supportedLocales,
          builder: (context, child) => Material(
            child: CupertinoTheme(
              data: ThemeDataUtil.buildCupertinoThemeData(context, context.theme.brightness),
              child: child!,
            ),
          ),
        );
      });
    });
  }
}
