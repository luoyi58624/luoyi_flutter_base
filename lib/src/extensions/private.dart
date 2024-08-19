import 'package:flutter/rendering.dart';

import '../commons/global.dart';

extension TextStyleExtension on TextStyle {
  /// 有些全局文本属性不应该被 [DefaultTextStyle] 覆写，当使用 [DefaultTextStyle] 组件时，
  /// 如果没有考虑 merge 祖先默认的样式，就会直接导致祖先定义的全局文本直接失效，
  /// 所以，当使用 [TextWidget] 时，下面这些属性将被强制应用，不允许通过 [DefaultTextStyle] 提供。
  TextStyle get applyForceTextStyle {
    return copyWith(
      fontFamily: GlobalConfig.textStyle.fontFamily,
      fontFamilyFallback: GlobalConfig.textStyle.fontFamilyFallback,
    );
  }
}
