import 'package:base_example/global.dart';
import 'package:flutter/material.dart';

class LocalObsPage extends StatefulWidget {
  const LocalObsPage({super.key});

  @override
  State<LocalObsPage> createState() => _LocalObsPageState();
}

class _LocalObsPageState extends State<LocalObsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('本地响应式变量'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            AppDataController.of.count.value++;
          },
          child: Obx(() => Text('count: ${AppDataController.of.count.value}')),
        ),
      ),
    );
  }
}
