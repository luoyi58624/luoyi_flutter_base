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
            P([
              'Hello, ',
              B('World'),
              A('百度', href: 'https://www.baidu.com'),
              B([
                '百度',
                A('百度', href: 'https://www.baidu.com'),
              ]),
            ]),
            P(
              B(
                [
                  '1',
                  A('2', href: 'https://www.baidu.com'),
                  '3',
                  A('4', href: 'https://www.baidu.com'),
                  '5',
                  I([
                    '3',
                    A('4', href: 'https://www.baidu.com'),
                    '5',
                    H1(
                      [
                        '一级标题',
                        H2('二级标题'),
                        A('百度', href: 'https://www.baidu.com'),
                        P(
                          style: TextStyle(fontStyle: FontStyle.normal),
                          A('百度', href: 'https://www.baidu.com'),
                        ),
                      ],
                      style: TextStyle(color: Colors.green),
                    ),
                  ])
                ],
              ),
            ),
            RichText(
              text: TextSpan(
                  style: TextStyle(color: Colors.red),
                  children: [
                    TextSpan(text: 'xxx'),
                    WidgetSpan(
                      alignment: PlaceholderAlignment.baseline,
                      baseline: TextBaseline.alphabetic,
                      child: Text('xxx'),
                    ),
                    TextSpan(children: [
                      TextSpan(text: 'xxx'),
                      WidgetSpan(
                        alignment: PlaceholderAlignment.baseline,
                        baseline: TextBaseline.alphabetic,
                        child: Text('xxx'),
                      ),
                    ])
                  ]),
            ),
          ],
        ),
      ),
    );
  }
}
