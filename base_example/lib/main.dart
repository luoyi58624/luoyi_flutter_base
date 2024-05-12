import 'package:base_example/pages/root.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:luoyi_flutter_font/luoyi_flutter_font.dart';

import 'global.dart';

void main() async {
  await initApp();
  await FlutterFont.init(FlutterFontModel.notoSansSC);
  Get.put(AppDataController(
      config: FlutterConfigData(
    fontFamily: FlutterFont.fontFamily,
  )));
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
          theme: ThemeData(brightness: Brightness.light).applyAppData(context),
          darkTheme: ThemeData(brightness: Brightness.dark).applyAppData(context),
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
              data: CupertinoThemeData(brightness: context.theme.brightness).applyAppData(context),
              child: child!,
            ),
          ),
        );
      });
    });
  }
}
