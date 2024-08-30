import 'dart:ui';

import 'package:example/animate_hover.dart';
import 'package:example/main.dart';
import 'package:flutter/material.dart';
import 'package:luoyi_flutter_base/luoyi_flutter_base.dart';

import 'animate_tap.dart';

class AnimateHoverTestPage extends StatefulWidget {
  const AnimateHoverTestPage({super.key});

  @override
  State<AnimateHoverTestPage> createState() => _AnimateHoverTestPageState();
}

class _AnimateHoverTestPageState extends State<AnimateHoverTestPage> {
  @override
  Widget build(BuildContext context) {
    Tween();
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
      body: Column(
        children: [
          AnimateTapBuilder(builder: (context) {
            final activeT = AnimateTapBuilder.t(context);
            final color = Theme.of(context).colorScheme.primary;
            final activeColor = color.deepen(20,reversal: true);
            return Container(
              width: 300,
              height: 300,
              color: color.lerp(activeColor, activeT),
            );
          }),
          AnimateTapBuilder(builder: (context) {
            return AnimateHoverBuilder(
              duration: 250.ms,
              curve: Curves.easeInOut,
              builder: (context) {
                final hoverT = AnimateHoverBuilder.t(context);
                final activeT = AnimateTapBuilder.t(context);
                final color = Theme.of(context).colorScheme.primary;
                final hoverColor = color.deepen(20);
                final activeColor = color.deepen(20,reversal: true);
                return Container(
                  width: 300,
                  height: 300,
                  color: color.lerp(hoverColor, hoverT).lerp(activeColor, activeT),
                );
              },
            );
          }),
        ],
      ),
    );
  }
}
