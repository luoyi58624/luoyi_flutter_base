import 'package:base_example/global.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class HookPage extends HookWidget {
  const HookPage({super.key});

  @override
  Widget build(BuildContext context) {
    i('parent build');
    final count = useState(0);
    final name = useState('luoyi');
    return Scaffold(
      appBar: AppBar(
        title: const Text('Hook测试'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: Column(
            children: [
              ElevatedButton(
                onPressed: () {
                  count.value++;
                },
                child: Text('count: ${count.value}'),
              ),
              _Child(count: count),
              Text('name: ${name.value}'),
              _InputWidget(name),
            ],
          ),
        ),
      ),
    );
  }
}

class _Child extends HookWidget {
  const _Child({required this.count});

  final ValueNotifier<int> count;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        count.value++;
      },
      child: Text('count: ${count.value}'),
    );
  }
}

class _InputWidget extends HookWidget {
  _InputWidget(this.modelValue);

  final ValueNotifier<String> modelValue;

  late final c = useTextEditingController(text: modelValue.value);

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: c,
      onChanged: (v) {
        modelValue.value = v;
      },
    );
  }
}
