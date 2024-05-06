import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:luoyi_flutter_base/luoyi_flutter_base.dart';

class ColorTestPage extends HookWidget {
  const ColorTestPage({super.key});

  List<Widget> buildColors() {
    List<Widget> widgets = [];
    FlutterColorData.materialColors.forEach((k, v) => FlutterColorData.materialColorSwatchs.forEach((i) {
          widgets.add(Container(
            width: 100,
            height: 100,
            color: v[i],
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    k,
                    style: TextStyle(
                      color: v[i]!.isDark ? Colors.white : Colors.black,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '${v[i]!.hsp}',
                    style: TextStyle(
                      color: v[i]!.isDark ? Colors.white : Colors.black,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '$i',
                    style: TextStyle(
                      color: v[i]!.isDark ? Colors.white : Colors.black,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    v[i]!.toHex(hasLeading: true),
                    style: TextStyle(
                      color: v[i]!.isDark ? Colors.white : Colors.black,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          ));
        }));

    return widgets;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Color测试'),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Wrap(
            children: buildColors(),
          ),
        ),
      ),
    );
  }
}
