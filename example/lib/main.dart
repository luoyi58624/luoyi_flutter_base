import 'package:flutter/material.dart';
import 'package:luoyi_flutter_base/luoyi_flutter_base.dart';

void main() {
  runApp(const _App());
}

class _App extends StatelessWidget {
  const _App();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        navigatorKey: GlobalConfig.navigatorKey,
        home: const HomePage(),
        builder: (context, child) {
          return Material(
            child: Overlay(initialEntries: [
              OverlayEntry(builder: (context) {
                return child!;
              }),
            ]),
          );
        });
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Example'),
      ),
      body: const SingleChildScrollView(
        child: SizedBox(
          width: double.infinity,
        ),
      ),
    );
  }
}
