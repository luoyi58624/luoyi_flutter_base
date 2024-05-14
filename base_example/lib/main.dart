import 'package:base_example/pages/root.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'global.dart';

/// 根节点导航key
final GlobalKey<NavigatorState> rootNavigatorKey = GlobalKey<NavigatorState>();

/// 根节点context
BuildContext get rootContext => rootNavigatorKey.currentContext!;

void main() async {
  await initApp();
  var _fontFamilyFallback = await FlutterFont.init();
  await FlutterFont.initSystemFontWeight();
  await CacheInterceptor.init();
  LoadingUtil.init(rootNavigatorKey);
  Get.put(AppDataController(
      config: AppConfigData(
    fontFamily: FlutterFont.fontFamily,
    fontFamilyFallback: _fontFamilyFallback,
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
          navigatorKey: rootNavigatorKey,
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
          builder: ToastUtil.builder(
            (context, child) => Material(
              child: CupertinoTheme(
                data: CupertinoThemeData(brightness: context.theme.brightness).applyAppData(context),
                child: child!,
              ),
            ),
          ),
        );
      });
    });
  }
}
