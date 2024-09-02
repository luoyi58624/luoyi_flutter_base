import 'dart:ui';

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
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ElHoverBuilder(builder: (context) {
            return ElTapBuilder(
              builder: (context) {
                return AnimatedContainer(
                  duration: ElTapBuilder.of(context) || ElHoverBuilder.of(context)
                      ? 500.ms
                      : Duration.zero,
                  width: ElTapBuilder.of(context)
                      ? 100
                      : ElHoverBuilder.of(context)
                          ? 400
                          : 200,
                  height: 100,
                  color: context.colorBuilder(
                    color,
                    activeColor: color.deepen(20, reversal: true),
                    hoverColor: color.deepen(20),
                  ),
                );
              },
            );
          }),
          // const Gap(8),
          // ElHoverBuilder(
          //   enableAnimate: true,
          //   duration: 1000.ms,
          //   builder: (context) {
          //     return ElTapBuilder(
          //       enableAnimate: true,
          //       duration: 200.ms,
          //       builder: (context) {
          //         const width = 200.0;
          //         const activeWidth = 100.0;
          //         const hoverWidth = 400.0;
          //         final activeT = ElTapBuilder.t(context);
          //         final hoverT = ElHoverBuilder.t(context);
          //         late double target;
          //         if (activeT > 0.0) {
          //           target = lerpDouble(width, activeWidth, activeT)!;
          //         } else if (hoverT > 0.0) {
          //           target = lerpDouble(width, hoverWidth, hoverT)!;
          //         } else {
          //           target = width;
          //         }
          //         return Container(
          //           width: target,
          //           height: 100,
          //           color: context.colorLerpBuilder(
          //             color,
          //             activeColor: color.deepen(20, reversal: true),
          //             hoverColor: color.deepen(20),
          //           ),
          //         );
          //       },
          //     );
          //   },
          // ),
          // const Gap(8),
          // ElTapBuilder(
          //   duration: 100.ms,
          //   builder: (context) {
          //     final activeT = ElTapBuilder.t(context);
          //     final color = Theme.of(context).colorScheme.primary;
          //     final activeColor = color.deepen(20, reversal: true);
          //     return Container(
          //       width: 100,
          //       height: 100,
          //       color: color.lerp(activeColor, activeT),
          //     );
          //   },
          // ),
        ],
      ),
    );
  }
}
