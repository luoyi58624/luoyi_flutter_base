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
      builder: (context, child) => Material(
        child: BrightnessWidget(
          child: Overlay(initialEntries: [
            OverlayEntry(builder: (context) {
              return child!;
            }),
          ]),
        ),
      ),
    );
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
      body: Center(
        child: Column(
          children: [
            const DefaultTextStyle(
              style: TextStyle(color: Colors.grey),
              child: H1(
                [
                  '一级标题 (H1)',
                  H4(
                    '四级标题',
                    style: TextStyle(fontWeight: FontWeight.w100),
                  )
                ],
                // style: TextStyle(fontWeight: FontWeight.w400),
              ),
            ),
            A(
              href: 'https://www.baidu.com',
              child: Builder(
                builder: (context) {
                  return ElevatedButton(
                    onPressed: () {
                      i(A.of(context));
                    },
                    child: const Text('百度'),
                  );
                }
              ),
            ),
            A(
              href: 'https://www.bing.com',
              child: Builder(
                  builder: (context) {
                    return ElevatedButton(
                      onPressed: () {
                        i(A.of(context));
                      },
                      child: const Text('Bing'),
                    );
                  }
              ),
            ),
          ],
        ),
      ),
    );
  }
}
