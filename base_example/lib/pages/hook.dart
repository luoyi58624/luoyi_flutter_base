import 'package:base_example/widgets/button.dart';
import 'package:flutter/material.dart';
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
          color: context.appTheme.primary,
          onPressed: () {
            count.value++;
          },
          child: Text('count: ${count.value}'),
        ),
        const SizedBox(height: 8),
        ButtonWidget(
          color: context.appTheme.success,
          onPressed: () {
            count.value++;
          },
          child: Text('count: ${count.value}'),
        ),
        const SizedBox(height: 8),
        ButtonWidget(
          color: context.appTheme.warning,
          onPressed: () {
            count.value++;
          },
          child: Text('count: ${count.value}'),
        ),
        const SizedBox(height: 8),
        ButtonWidget(
          color: context.appTheme.error,
          onPressed: () {
            count.value++;
          },
          child: Text('count: ${count.value}'),
        ),
        const SizedBox(height: 8),
        ButtonWidget(
          color: context.appTheme.info,
          onPressed: () {
            count.value++;
          },
          child: Text('count: ${count.value}'),
        ),
      ]),
    );
  }
}
