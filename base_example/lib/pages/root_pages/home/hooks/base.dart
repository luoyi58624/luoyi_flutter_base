import 'package:base_example/global.dart';
import 'package:flutter/material.dart';

class BaseHookPage extends HookWidget {
  const BaseHookPage({super.key});

  @override
  Widget build(BuildContext context) {
    final count = useState(0);
    return Scaffold(
      appBar: AppBar(
        title: const Text('基础Hook示例'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: buildCenterColumn([
          ElevatedButton(
            onPressed: () {
              count.value++;
            },
            child: Text('count: ${count.value}'),
          ),
          _Child(count: count),
        ]),
      ),
    );
  }
}

class _Child extends HookWidget {
  const _Child({required this.count});

  final ValueNotifier<int> count;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        count.value++;
      },
      child: Text('child count: ${count.value}'),
    );
  }
}
