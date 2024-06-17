import 'package:flutter/material.dart';

import '../global.dart';

class TestPage extends StatefulWidget {
  const TestPage({super.key});

  @override
  State<TestPage> createState() => _TestPageState();
}

class _TestPageState extends State<TestPage> {
  int count = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('测试页面'),
      ),
      body: Column(
        children: [
          ElevatedButton(
            onPressed: () {
              setState(() {
                count++;
              });
            },
            child: Text('count: $count'),
          ),
          Div(
            'count: $count',
            style: const Style(
              width: 100,
              height: 100,
              color: Colors.white,
              backgroundColor: Colors.green,
              padding: [50, 0, 0, 0],
              margin: [20],
            ),
          ),
          const Gap(16),
          DemoWidget(count: count),
        ],
      ),
    );
  }
}

class DemoWidget extends StatelessWidget {
  const DemoWidget({super.key, required this.count});

  final int count;

  @override
  Widget build(BuildContext context) {
    int start = DateTime.now().microsecondsSinceEpoch;
    Widget result = UnconstrainedBox(
      child: Container(
        width: 100,
        height: 100,
        color: Colors.green,
        margin: const EdgeInsets.all(100),
        padding: const EdgeInsets.only(top: 50),
        child: DefaultTextStyle.merge(
          style: const TextStyle(
            color: Colors.white,
          ),
          child: Text(
            'count: $count',
          ),
        ),
      ),
    );
    i(DateTime.now().microsecondsSinceEpoch - start, '渲染DemoWidget耗时(微秒)');
    return result;
  }
}
