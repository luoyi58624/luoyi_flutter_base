import 'package:example/main.dart';
import 'package:flutter/material.dart';
import 'package:luoyi_flutter_base/luoyi_flutter_base.dart';

class AnimateHoverTestPage extends StatefulWidget {
  const AnimateHoverTestPage({super.key});

  @override
  State<AnimateHoverTestPage> createState() => _AnimateHoverTestPageState();
}

class _AnimateHoverTestPageState extends State<AnimateHoverTestPage> {
  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme.primary;
    return Scaffold(
      appBar: AppBar(
        title: const Text('动画Hover'),
        actions: [
          ObsBuilder(builder: (context) {
            return Switch(
              value: isDark.value,
              onChanged: (v) => isDark.value = v,
            );
          })
        ],
      ),
      body: Column(crossAxisAlignment: CrossAxisAlignment.start, children: []),
    );
  }
}
