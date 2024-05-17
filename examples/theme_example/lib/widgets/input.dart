import 'package:theme_example/global.dart';
import 'package:theme_example/widgets/common.dart';

class InputWidgets extends HookWidget {
  const InputWidgets({super.key});

  @override
  Widget build(BuildContext context) {
    final inputController = useTextEditingController();
    return ComponentDecoration(title: 'Inputs', children: [
      const Gap(16),
      TextField(
        onChanged: (v) => inputController.text = v,
        controller: inputController,
        decoration: const InputDecoration(
          label: Text('用户名'),
        ),
      ),
      const Gap(16),
      TextField(
        onChanged: (v) => inputController.text = v,
        controller: inputController,
        decoration: const InputDecoration(
          label: Text('用户名'),
          filled: true,
        ),
      ),
      const Gap(16),
      TextField(
        onChanged: (v) => inputController.text = v,
        controller: inputController,
        decoration: const InputDecoration(
          label: Text('用户名'),
          filled: true,
          border: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey),
          ),
          contentPadding: EdgeInsets.only(top: 8, bottom: 8, left: 16, right: 16),
        ),
      ),
      const Gap(16),
      TextField(
        onChanged: (v) => inputController.text = v,
        controller: inputController,
        decoration: const InputDecoration(
          label: Text('用户名'),
          border: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey),
          ),
          contentPadding: EdgeInsets.only(top: 8, bottom: 8, left: 16, right: 16),
        ),
      ),
    ]);
  }
}
