import 'package:flutter/material.dart';
import 'package:luoyi_dart_base/luoyi_dart_base.dart';
import 'package:luoyi_flutter_base/element_ui/components/hover.dart';
import 'package:luoyi_flutter_base/element_ui/components/tap.dart';

import '../commons/global.dart';

extension FlutterIntExtension on int {
  /// int转[FontWeight]
  FontWeight toFontWeight([FontWeight? defaultFontWeight]) {
    switch (this) {
      case 100:
        return FontWeight.w100;
      case 200:
        return FontWeight.w200;
      case 300:
        return FontWeight.w300;
      case 400:
        return FontWeight.w400;
      case 500:
        return FontWeight.w500;
      case 600:
        return FontWeight.w600;
      case 700:
        return FontWeight.w700;
      case 800:
        return FontWeight.w800;
      case 900:
        return FontWeight.w900;
      default:
        return defaultFontWeight ?? FontWeight.normal;
    }
  }

  /// 动态调整隐式动画小部件的持续时间，如果是悬停、点击等事件引起的状态更新，则使用自定义的持续时间，
  /// 否则使用全局主题变化持续时间，这样可以解决切换全局主题时过渡不一致问题
  Duration themeDuration(BuildContext context) {
    if (ElHoverBuilder.of(context) || ElTapBuilder.of(context)) {
      return ms;
    } else {
      return GlobalConfig.themeDuration;
    }
  }
}
