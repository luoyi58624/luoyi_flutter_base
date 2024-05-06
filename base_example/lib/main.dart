import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:luoyi_flutter_base/luoyi_flutter_base.dart';
import 'package:mini_getx/mini_getx.dart';

import 'pages/home.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return materialApp();
  }

  Widget materialApp() {
    return MaterialApp(
      theme: ThemeData(brightness: Brightness.light).copyWith(extensions: [
        const FlutterThemeData(),
      ]),
      darkTheme: ThemeData(brightness: Brightness.dark).copyWith(extensions: [
        const FlutterThemeData.dark(),
      ]),
      home: const HomePage(),
    );
  }

  Widget cupertinoApp() {
    return const CupertinoApp(
      theme: CupertinoThemeData(),
      home: CupertionHomePage(),
    );
  }

  Widget demoApp() {
    return MaterialApp(
      theme: ThemeData(
        brightness: Brightness.light,
        pageTransitionsTheme: const PageTransitionsTheme(builders: {
          TargetPlatform.android: CupertinoPageTransitionsBuilder(),
          TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
          TargetPlatform.macOS: CupertinoPageTransitionsBuilder(),
        }),
      ).copyWith(extensions: [
        const FlutterThemeData(),
      ]),
      darkTheme: ThemeData(brightness: Brightness.dark).copyWith(extensions: [
        const FlutterThemeData.dark(),
      ]),
      home: const CupertionHomePage(),
      builder: (context, child) => CupertinoTheme(
        data: CupertinoThemeData(brightness: context.theme.brightness),
        child: child!,
      ),
    );
  }
}
