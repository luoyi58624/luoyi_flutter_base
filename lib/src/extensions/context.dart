import 'package:flutter/widgets.dart';

import '../../element_ui/components/hover.dart';
import '../../element_ui/components/tap.dart';

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
}
