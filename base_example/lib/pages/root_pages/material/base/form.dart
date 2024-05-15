import 'package:base_example/global.dart';
import 'package:flutter/material.dart';

class FormPage extends HookWidget {
  const FormPage({super.key});

  @override
  Widget build(BuildContext context) {
    final username = useState('');
    final selected = useState(false);
    return HideKeyboardWidget(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('FormPage测试'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              _InputWidget(username, label: '用户名'),
              Switch(
                onChanged: (v) => selected.value = v,
                value: selected.value,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _InputWidget extends HookWidget {
  _InputWidget(this.modelValue, {this.label});

  final ValueNotifier<String> modelValue;

  final String? label;

  late final c = useTextEditingController(text: modelValue.value);

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: c,
      onChanged: (v) {
        modelValue.value = v;
      },
      decoration: InputDecoration(
        label: Text(label ?? ''),
      ),
    );
  }
}
