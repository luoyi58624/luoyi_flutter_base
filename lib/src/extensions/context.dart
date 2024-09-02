import 'package:flutter/widgets.dart';

import '../../element_ui/components/hover.dart';
import '../../element_ui/components/tap.dart';
import '../commons/global.dart';

extension FlutterContextExtension on BuildContext {
  bool get isHover => ElHoverBuilder.of(this);

  bool get isTap => ElTapBuilder.of(this);

  Color colorBuilder(
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

  /// 动态调整隐式动画小部件的持续时间，如果是悬停、点击等事件引起的状态更新，则使用自定义的持续时间，
  /// 否则使用全局主题变化持续时间，这样可以解决切换全局主题时过渡不一致问题
  Duration eventAnimateDuration(Duration duration) {
    if (isHover || isTap) {
      return duration;
    } else {
      return GlobalConfig.themeDuration;
    }
  }
}
