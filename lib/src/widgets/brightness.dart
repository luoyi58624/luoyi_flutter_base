import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

extension BrightnessExtension on BuildContext {
  /// 当前环境是否是暗黑模式
  bool get isDark => BrightnessWidget.of(this) == Brightness.dark;
}

class BrightnessWidget extends InheritedWidget {
  /// 平台亮度小部件，通过此小部件用于抹平不同主题设计系统访问主题的差异，例如：
  /// ```dart
  /// Theme.of(context).brightness == Brightness.dark;
  /// CupertinoTheme.of(context).brightness == Brightness.dark;
  /// ```
  ///
  /// 此小部件只应用于内部，不对外公开，判断是否是黑暗模式请自行根据应用的主题系统进行封装即可。
  const BrightnessWidget({
    super.key,
    required super.child,
    this.brightness,
  });

  final Brightness? brightness;

  static Brightness of(BuildContext context) {
    final BrightnessWidget? result =
        context.dependOnInheritedWidgetOfExactType<BrightnessWidget>();
    return result?.brightness ?? MediaQuery.of(context).platformBrightness;
  }

  @override
  bool updateShouldNotify(BrightnessWidget oldWidget) => true;
}
