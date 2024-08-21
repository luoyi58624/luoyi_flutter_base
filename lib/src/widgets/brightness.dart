import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

extension BrightnessExtension on BuildContext {
  /// 当前环境是否是暗黑模式
  bool get isDark => BrightnessWidget.of(this) == Brightness.dark;
}

class BrightnessWidget extends InheritedWidget {
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
