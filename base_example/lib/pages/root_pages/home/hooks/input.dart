import 'package:base_example/global.dart';
import 'package:flutter/material.dart';

class InputHookePage extends HookWidget {
  const InputHookePage({super.key});

  @override
  Widget build(BuildContext context) {
    final name = useState('luoyi');
    return Scaffold(
      appBar: AppBar(
        title: const Text('Input双向绑定示例'),
      ),
      body: buildCenterColumn([
        Text('name: ${name.value}'),
        _InputWidget(name),
      ]),
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
