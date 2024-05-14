import 'package:base_example/global.dart';
import 'package:flutter/material.dart';

class _Controller extends GetxController {
  final count = 0.obs;
}

class GetxHookPage extends HookWidget {
  const GetxHookPage({super.key});

  @override
  Widget build(BuildContext context) {
    final c = useGetx(_Controller());
    return Scaffold(
      appBar: AppBar(
        title: const Text('Getx控制器hook'),
      ),
      body: buildCenterColumn([
        ElevatedButton(
          onPressed: () {
            c.count.value++;
          },
          child: Obx(() {
            return Text('getx count: ${c.count.value}');
          }),
        ),
        const _GetxChild(),
      ]),
    );
  }
}

class _GetxChild extends HookWidget {
  const _GetxChild();

  @override
  Widget build(BuildContext context) {
    _Controller c = Get.find();
    return ElevatedButton(
      onPressed: () {
        c.count.value++;
      },
      child: Obx(() {
        return Text('getx child count: ${c.count.value}');
      }),
    );
  }
}
