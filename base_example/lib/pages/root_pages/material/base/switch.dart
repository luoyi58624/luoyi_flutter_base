import 'package:base_example/global.dart';
import 'package:flutter/material.dart';

class SwitchPage extends HookWidget {
  const SwitchPage({super.key});

  @override
  Widget build(BuildContext context) {
    final selected = useState(false);
    return Scaffold(
      appBar: AppBar(
        title: const Text('SwitchPage测试'),
      ),
      body: buildCenterColumn([
        Switch(
          onChanged: (v) => selected.value = v,
          value: selected.value,
        ),
      ]),
    );
  }
}
