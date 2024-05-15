import 'package:base_example/global.dart';
import 'package:flutter/material.dart';

class RefreshPage extends HookWidget {
  const RefreshPage({super.key});

  @override
  Widget build(BuildContext context) {
    final selected = useState(false);
    return Scaffold(
      appBar: AppBar(
        title: const Text('刷新器'),
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
