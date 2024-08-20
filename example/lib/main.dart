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
              'xxx',
              'xxx',
              'xxx',
              A(
                '百度',
                href: 'https://www.baidu.com',
                decoration: HrefDecoration.hoverUnderline,
              ),
              'xxx',
              'xxx',
              P(
                '百度',
                style: TextStyle(fontSize: 50),
              ),
            ]),
            P([
              'xxx',
              P('xxx'),
              'xxx',
              Del(
                B([
                  '哈喽',
                  A(
                    '百度',
                    href: 'https://www.baidu.com',
                    color: Colors.grey,
                  ),
                  '哈喽',
                ]),
              ),
              'xxx',
              '百度',
              H1('一级标题'),
              Container(
                width: 50,
                height: 50,
                color: Colors.green,
              )
            ]),
            B([
              '哈喽',
              A(
                '百度',
                href: 'https://www.baidu.com',
                decoration: HrefDecoration.hoverUnderline,
              ),
              '哈喽',
            ]),
            P(
              B([
                '百度',
                // A('百度', href: 'https://www.baidu.com'),
                Text('hal'),
              ]),
            ),
            // test2(),
            DefaultTextStyle(
              style: TextStyle(
                color: Colors.black,
              ),
              child: Builder(builder: (context) {
                return RichText(
                  text: TextSpan(
                    style: DefaultTextStyle.of(context).style,
                    children: [
                      TextSpan(text: 'hello'),
                      TextSpan(
                        children: [
                          TextSpan(
                            style: DefaultTextStyle.of(context)
                                .style
                                .copyWith(color: Colors.red),
                            children: [
                              WidgetSpan(
                                child: Builder(
                                  builder: (context) =>
                                      DefaultTextStyle.merge(child: Text('xx')),
                                ),
                              ),
                              WidgetSpan(
                                child: Builder(
                                  builder: (context) => Text('xx'),
                                ),
                              ),
                              TextSpan(text: 'hello'),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              }),
            ),
          ],
        ),
      ),
    );
  }

  Widget test2() {
    return TextWidget(
      [
        'xxx',
        '富文本',
        'xxx',
        const TextSpan(
          text: 'xxx',
          style: TextStyle(color: Colors.green),
        ),
        const TextWidget(
          'xxx',
          style: TextStyle(color: Colors.red),
        ),
        const TextWidget(
          ['xxx', '富文本', 'ccc'],
          style: TextStyle(color: Colors.blue),
        ),
        const WidgetSpan(
          alignment: PlaceholderAlignment.middle,
          child: Icon(Icons.home),
        ),
        // WidgetSpan(
        //   alignment: PlaceholderAlignment.middle,
        //   child: Container(
        //     width: 100,
        //     height: 100,
        //     color: Colors.green,
        //   ),
        // ),
        // WidgetSpan(
        //   alignment: PlaceholderAlignment.baseline,
        //   baseline: TextBaseline.alphabetic,
        //   child: Container(
        //     width: 100,
        //     height: 100,
        //     color: Colors.green,
        //   ),
        // ),
        Container(
          width: 100,
          height: 100,
          color: Colors.red,
        ),
        'xxx',
        WidgetSpan(
          alignment: PlaceholderAlignment.baseline,
          baseline: TextBaseline.alphabetic,
          child: HoverBuilder(builder: (context) {
            return TextWidget(
              'xxx',
              style: TextStyle(
                color: HoverBuilder.of(context) ? Colors.red : null,
              ),
            );
          }),
        ),
        'xxx',
        const A(
          'https://www.baidu.com',
          href: 'https://www.baidu.com',
        ),
        // WidgetSpan(
        //   child: const ElButton(
        //     onPressed: null,
        //     child: '百度',
        //     link: true,
        //   ),
        // ),
        const TextWidget(
          ['呃呃呃', '呃呃呃'],
          style: TextStyle(color: Colors.red),
        ),
      ],
      style: const TextStyle(fontWeight: FontWeight.w500),
    );
  }
}
