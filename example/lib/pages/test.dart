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
          Expanded(
            child: Row(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemBuilder: (context, index) => DemoWidget(count: count),
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    itemBuilder: (context, index) => const Div(
                      'count:',
                      style: Style(
                        width: 100,
                        height: 100,
                        color: Colors.white,
                        backgroundColor: Colors.green,
                        padding: [0, 0, 0, 0],
                        margin: [8],
                        alignment: Alignment.center,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
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
        margin: const EdgeInsets.all(8),
        padding: const EdgeInsets.all(0),
        alignment: Alignment.center,
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
