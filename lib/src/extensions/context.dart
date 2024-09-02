import 'package:flutter/widgets.dart';

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
}
