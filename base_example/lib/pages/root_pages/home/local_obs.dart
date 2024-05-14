import 'package:flutter/material.dart';
import 'package:base_example/global.dart';

class LocalObsPage extends HookWidget {
  const LocalObsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('本地响应式变量'),
      ),
      body: Center(
        child: Column(
          children: [
            ElevatedButton(
              onPressed: () {
                AppDataController.of.count.value++;
              },
              child: Obx(() => Text('count: ${AppDataController.of.count.value}')),
            ),
          ],
        ),
      ),
    );
  }
}
