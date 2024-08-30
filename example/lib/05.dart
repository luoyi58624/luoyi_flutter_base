import 'package:flutter/material.dart';
import 'package:luoyi_flutter_base/luoyi_flutter_base.dart';

class Example5 extends HookWidget {
  const Example5({super.key});

  @override
  Widget build(BuildContext context) {
    // final width = useAnimateObs(100.0);
    // final height = useAnimateObs(100.0);
    final count = useState(0);
    final controller = useAnimationController();
    final controller2 = useAnimationController();
    final count2 = useState(0);
    final size = useAnimateObs(
      const Size(100, 100),
      duration: const Duration(milliseconds: 200),
      tweenBuilder: () => SizeTween(),
    );
    final color = useAnimateObs(
      Colors.green,
      duration: const Duration(milliseconds: 200),
      tweenBuilder: () => ColorTween(),
    );

    // final count = useState(0);

    final flag = useState(false);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Example'),
        actions: [
          Switch(
            value: flag.value,
            onChanged: (v) {
              flag.value = v;
              if (v) {
                size.setAnimateValue(const Size(300, 300));
                color.value = Colors.red;
              } else {
                size.setAnimateValue(const Size(100, 100));
                color.value = Colors.green;
              }
            },
          )
        ],
      ),
      body: Column(
        children: [
          ObsBuilder(
              watch: [size],
              builder: (context) {
                // print('${size.controller.value}  ${size.animation.value}');
                return Container(
                  width: size.animation.value!.width,
                  height: size.animation.value!.height,
                  decoration: BoxDecoration(
                    color: color.animation.value,
                  ),
                );
              }),
          // const SizedBox(height: 8),
          // ObsBuilder(
          //     watch: [width],
          //     builder: (context) {
          //       return Container(
          //         width: width.animation.value,
          //         height: height.animation.value,
          //         decoration: const BoxDecoration(
          //           color: Colors.red,
          //         ),
          //       );
          //     }),
        ],
      ),
    );
  }
}
