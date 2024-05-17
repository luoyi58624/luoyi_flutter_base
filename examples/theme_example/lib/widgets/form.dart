import 'package:theme_example/global.dart';
import 'package:theme_example/widgets/common.dart';

class FormWidgets extends HookWidget {
  const FormWidgets({super.key});

  @override
  Widget build(BuildContext context) {
    final switchValue = useState(true);
    return ComponentDecoration(title: 'Form', children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Switch(value: false, onChanged: (v) {}),
          Switch(value: switchValue.value, onChanged: (v) => switchValue.value = v),
          CupertinoSwitch(value: false, onChanged: (v) {}),
          CupertinoSwitch(value: switchValue.value, onChanged: (v) => switchValue.value = v),
        ],
      ),
    ]);
  }
}
