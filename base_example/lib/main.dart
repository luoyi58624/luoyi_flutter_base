import 'package:flutter/material.dart';
import 'package:luoyi_flutter_base/luoyi_flutter_base.dart';

import 'pages/home.dart';

void main() async {
  await initApp();
  Get.put(AppDataController());
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
      return MaterialApp(
        theme: ThemeDataUtil.buildThemeData(context, Brightness.light),
        darkTheme: ThemeDataUtil.buildThemeData(context, Brightness.dark),
        home: const HomePage(),
        localizationsDelegates: const [
          GlobalWidgetsLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
      );
    });
  }
}
