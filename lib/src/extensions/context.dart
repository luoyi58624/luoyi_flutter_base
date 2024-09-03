import 'package:flutter/widgets.dart';

import '../../element_ui/components/hover.dart';
import '../../element_ui/components/duration.dart';
import '../../element_ui/components/tap.dart';

extension FlutterContextExtension on BuildContext {
  bool get isHover => ElHoverBuilder.of(this);

  bool get isTap => ElTapBuilder.of(this);

  /// 获取响应事件触发的动画持续时间，默认情况下，
  Duration? get themeDuration => ElThemeDuration.maybeOf(this);

  /// 构建由响应事件触发的颜色状态
  Color buildEventColor(
    Color color, {
    Color? activeColor,
    Color? hoverColor,
  }) {
    Color result = color;
    if (activeColor != null) {
      if (isTap) {
        return activeColor;
      }
    }
    if (hoverColor != null) {
      if (isHover) {
        return hoverColor;
      }
    }
    return result;
  }
}
