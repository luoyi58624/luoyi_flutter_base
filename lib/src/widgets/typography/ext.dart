import 'package:flutter/rendering.dart';

import '../../commons/global.dart';

extension TextStyleExt on TextStyle {
  /// 应用覆写 [DefaultTextStyle] 文本样式
  TextStyle get applyForceTextStyle {
    return copyWith(
      fontFamily: GlobalConfig.textStyle.fontFamily,
      fontFamilyFallback: GlobalConfig.textStyle.fontFamilyFallback,
    );
  }
}
