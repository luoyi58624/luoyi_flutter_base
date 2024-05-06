import 'package:base_example/widgets/button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:luoyi_flutter_base/luoyi_flutter_base.dart';

class HookTestPage extends HookWidget {
  const HookTestPage({super.key});

  @override
  Widget build(BuildContext context) {
    var count = useState(0);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Hook测试'),
      ),
      body: buildCenterColumn([
        ButtonWidget(
          onPressed: () {
            count.value++;
          },
          child: Text('count: ${count.value}'),
        ),
        const SizedBox(height: 8),
        ButtonWidget(
          color: context.flutterTheme.primary,
          onPressed: () {
            count.value++;
          },
          child: Text('count: ${count.value}'),
        ),
        const SizedBox(height: 8),
        ButtonWidget(
          color: context.flutterTheme.success,
          onPressed: () {
            count.value++;
          },
          child: Text('count: ${count.value}'),
        ),
        const SizedBox(height: 8),
        ButtonWidget(
          color: context.flutterTheme.warning,
          onPressed: () {
            count.value++;
          },
          child: Text('count: ${count.value}'),
        ),
        const SizedBox(height: 8),
        ButtonWidget(
          color: context.flutterTheme.error,
          onPressed: () {
            count.value++;
          },
          child: Text('count: ${count.value}'),
        ),
        const SizedBox(height: 8),
        ButtonWidget(
          color: context.flutterTheme.info,
          onPressed: () {
            count.value++;
          },
          child: Text('count: ${count.value}'),
        ),
      ]),
    );
  }
}
