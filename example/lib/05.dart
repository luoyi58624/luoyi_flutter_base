import 'package:flutter/material.dart';
import 'package:luoyi_flutter_base/luoyi_flutter_base.dart';

class Example5 extends HookWidget {
  const Example5({super.key});

  @override
  Widget build(BuildContext context) {
    // final width = useAnimateObs(100.0);
    // final height = useAnimateObs(100.0);
    const defaultStyle = BoxDecoration(
      color: Colors.green,
    );
    final count = useState(0);
    final controller = useAnimationController();
    final controller2 = useAnimationController();
    final count2 = useState(0);
    final size = useAnimateObs(
      const Size(100, 100),
      duration: const Duration(milliseconds: 1200),
      tweenBuilder: () => SizeTween(),
    );
    final style = useAnimateObs(
      defaultStyle,
      duration: const Duration(milliseconds: 1200),
      tweenBuilder: () => DecorationTween(),
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
                style.value = BoxDecoration(
                  color: Colors.red,
                  border: Border.all(width: 6, color: Colors.green),
                );
              } else {
                size.setAnimateValue(const Size(100, 100));
                style.value = defaultStyle;
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
                i(style.value);
                // print('${size.controller.value}  ${size.animation.value}');
                return Container(
                  width: size.animation.value!.width,
                  height: size.animation.value!.height,
                  decoration: style.value,
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
