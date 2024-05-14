part of '../../luoyi_flutter_base.dart';

/// 点击空白区域隐藏软键盘widget
class HideKeyboardWidget extends StatelessWidget {
  const HideKeyboardWidget({super.key, required this.child, this.onlyHideKeyboard});

  final Widget child;
  final bool? onlyHideKeyboard; // 仅仅隐藏键盘，保留焦点

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: child,
      onTap: () async {
        if (onlyHideKeyboard != null && onlyHideKeyboard == true) {
          await SystemChannels.textInput.invokeMethod('TextInput.hide');
        } else {
          FocusScopeNode currentFocus = FocusScope.of(context);
          if (!currentFocus.hasPrimaryFocus && currentFocus.focusedChild != null) {
            FocusManager.instance.primaryFocus?.unfocus();
          }
        }
      },
    );
  }
}
