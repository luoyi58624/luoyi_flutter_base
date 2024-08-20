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
      body: SingleChildScrollView(
        child: SizedBox(
          width: double.infinity,
          child: Ol(
            // start: 1,
            children: [
              ...List.generate(5, (index) => const Li(child: '列表')),
              Ol(
                children: [
                  ...List.generate(3, (index) => const Li(child: '列表'))
                ],
              ),
              Ul(
                // nestGap: 300,
                // listStyleType: ListStyleType.none,
                children: [
                  ...List.generate(3, (index) => const Li(child: '列表')),
                  Ul(
                    listStyleType: ListStyleType.circle,
                    children: [
                      ...List.generate(3, (index) => const Li(child: '列表')),
                      Ul(
                        listStyleType: ListStyleType.square,
                        children: [
                          ...List.generate(3, (index) => const Li(child: '列表'))
                        ],
                      ),
                    ],
                  ),
                ],
              ),
              ...List.generate(95, (index) => const Li(child: '列表')),
            ],
          ),
        ),
      ),
    );
  }
}
