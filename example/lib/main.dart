import 'package:flutter/material.dart';
import 'package:luoyi_flutter_base/luoyi_flutter_base.dart';

void main() {
  runApp(const _App());
}

class _App extends HookWidget {
  const _App();

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(home: HomePage());
  }
}

class HomePage extends HookWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('首页'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: List.generate(100, (index) => const _Child()),
        ),
      ),
    );
  }
}

class _Child extends StatelessWidget {
  const _Child();

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.all(16),
      child: ColoredBox(
        color: Color(0xFFE0E0E0),
        child: SizedBox(
          width: double.maxFinite,
          height: 50,
          child: Text('Item'),
        ),
      ),
    );
  }
}
