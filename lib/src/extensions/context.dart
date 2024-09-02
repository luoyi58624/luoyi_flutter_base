import 'package:flutter/widgets.dart';

import '../widgets/hover.dart';
import '../widgets/tap.dart';

extension FlutterContextExtension on BuildContext {
  bool get isHover => HoverBuilder.of(this);

  bool get isTap => TapBuilder.of(this);

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
}
