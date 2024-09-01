import 'package:flutter/widgets.dart';
import 'package:luoyi_flutter_base/src/extensions/color.dart';

import '../widgets/hover.dart';
import '../widgets/tap.dart';

extension FlutterContextExtension on BuildContext {
  Color colorBuilder(
    Color color, {
    Color? activeColor,
    Color? hoverColor,
  }) {
    Color result = color;
    if (activeColor != null) {
      if (TapBuilder.of(this)) {
        return activeColor;
      }
    }
    if (hoverColor != null) {
      if (HoverBuilder.of(this)) {
        return hoverColor;
      }
    }
    return result;
  }

  Color colorLerpBuilder(
    Color color, {
    Color? activeColor,
    Color? hoverColor,
  }) {
    Color result = color;
    if (activeColor != null) {
      final t = TapBuilder.t(this);
      if (t > 0.0) {
        return color.lerp(activeColor, t);
      }
    }
    if (hoverColor != null) {
      final t = HoverBuilder.t(this);
      if (t > 0.0) {
        return color.lerp(hoverColor, t);
      }
    }
    return result;
  }
}
