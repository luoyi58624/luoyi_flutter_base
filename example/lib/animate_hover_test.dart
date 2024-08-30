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
      body: SelectionArea(
        child: Column(
          children: [
            TapBuilder(
              delay: 100,
              builder: (context) {
                final color = Theme.of(context).colorScheme.primary;
                final activeColor = color.deepen(20, reversal: true);
                return AnimatedContainer(
                  duration: 100.ms,
                  width: 100,
                  height: 100,
                  color: color.on(TapBuilder.of(context), color: activeColor),
                );
              },
            ),
            const Gap(8),
            AnimateTapBuilder(
              duration: 100.ms,
              builder: (context) {
                final activeT = AnimateTapBuilder.t(context);
                final color = Theme.of(context).colorScheme.primary;
                final activeColor = color.deepen(20, reversal: true);
                return Container(
                  width: 100,
                  height: 100,
                  color: color.lerp(activeColor, activeT),
                );
              },
            ),
            const Gap(8),
            AnimateTapBuilder(builder: (context) {
              return AnimateHoverBuilder(
                duration: 250.ms,
                curve: Curves.easeInOut,
                builder: (context) {
                  final hoverT = AnimateHoverBuilder.t(context);
                  final activeT = AnimateTapBuilder.t(context);
                  final color = Theme.of(context).colorScheme.primary;
                  final hoverColor = color.deepen(20);
                  final activeColor = color.deepen(20, reversal: true);
                  return Container(
                    width: 100,
                    height: 100,
                    color:
                        color.lerp(hoverColor, hoverT).lerp(activeColor, activeT),
                  );
                },
              );
            }),
          ],
        ),
      ),
    );
  }
}
