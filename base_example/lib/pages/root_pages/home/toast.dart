import 'package:base_example/global.dart';
import 'package:flutter/material.dart';

class ToastPage extends HookWidget {
  const ToastPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Toast测试'),
      ),
      body: Center(
        child: Column(
          children: [
            ElevatedButton(
              onPressed: () {
                ToastUtil.show('hello');
              },
              child: const Text('Toast'),
            ),
            ElevatedButton(
              onPressed: () {
                ToastUtil.primary('primary');
              },
              child: const Text('Primary Toast'),
            ),
            ElevatedButton(
              onPressed: () {
                ToastUtil.success('success');
              },
              child: const Text('Success Toast'),
            ),
            ElevatedButton(
              onPressed: () {
                ToastUtil.info('info');
              },
              child: const Text('Info Toast'),
            ),
            ElevatedButton(
              onPressed: () {
                ToastUtil.warning('warning');
              },
              child: const Text('Warning Toast'),
            ),
            ElevatedButton(
              onPressed: () {
                ToastUtil.error('error');
              },
              child: const Text('Error Toast'),
            ),
          ],
        ),
      ),
    );
  }
}
