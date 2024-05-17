import 'package:theme_example/global.dart';

List<Widget> get inputWidgets => [
      const TextField(
        decoration: InputDecoration(
          label: Text('表单'),
          hintText: '请输入验证码',
        ),
      ),
      const Gap(8),
      const FormTextFieldWidget(
        label: '表单',
        placeholder: '请输入验证码',
      ),
    ];
