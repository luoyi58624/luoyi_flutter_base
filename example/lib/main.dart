import 'package:flutter/material.dart';
import 'package:luoyi_flutter_base/luoyi_flutter_base.dart';

import 'animate_controller.dart';

void main() {
  runApp(const _App());
}

class _App extends StatelessWidget {
  const _App();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        navigatorKey: GlobalConfig.navigatorKey,
        home: const HomePage(),
        builder: (context, child) {
          return Material(
            child: Overlay(initialEntries: [
              OverlayEntry(builder: (context) {
                return child!;
              }),
            ]),
          );
        });
  }
}

class HomePage extends HookWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    useAnimationController();
    final width = useAnimateObs(const Size(100, 100),tween: SizeTween());
    final height = useAnimateObs(100.0);
    final flag = useState(false);
    useWatch(flag, (newValue, _) {
      if (newValue) {

        width.setAnimateValue(const Size(300, 200));
        height.setAnimateValue(200);
      } else {
        width.setAnimateValue(const Size(100, 100));
        height.setAnimateValue(100);
      }
    });
    return Scaffold(
      appBar: AppBar(
        title: const Text('Example'),
        actions: [
          Switch(
            value: flag.value,
            onChanged: (v) {
              flag.value = v;
            },
          )
        ],
      ),
      body: ObsBuilder(
        watch: [width],
        builder: (context) {
          return Container(
            width: width.animation.value!.width,
            height: width.animation.value!.height,
            decoration: const BoxDecoration(
              color: Colors.green,
            ),
          );
        }
      ),
    );
  }
}
