import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:luoyi_flutter_base/luoyi_flutter_base.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  bool isDark = false;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        brightness: isDark ? Brightness.dark : Brightness.light,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('home'),
        ),
        body: Center(
          child: Column(
            children: [
              const Gap(16),
              ElevatedButton(
                child: const Text('切换黑暗模式'),
                onPressed: () {
                  setState(() {
                    isDark = !isDark;
                  });
                },
              ),
              const _Child(),
            ],
          ),
        ),
      ),
      builder: (context, child) => BrightnessWidget(
        brightness: Theme.of(context).brightness,
        child: child!,
      ),
    );
  }
}

class _Child extends StatelessWidget {
  const _Child();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Gap(16),
        Text('黑暗模式：${CupertinoTheme.of(context).brightness == Brightness.dark}'),
        const Gap(16),
        Text('黑暗模式：${BrightnessWidget.isDark(context)}'),
      ],
    );
  }
}
