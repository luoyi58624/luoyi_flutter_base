import 'package:flutter/widgets.dart';
import 'package:luoyi_flutter_base/src/extensions/num.dart';
import 'package:luoyi_flutter_base/src/widgets/typography/ext.dart';

import '../../utils/font/font.dart';
import 'text.dart';

// ===========================================================================
// 标题的字体大小、字重不会被 DefaultTextStyle 覆盖
// ===========================================================================

class H1 extends TextWidget {
  /// 一级标题
  const H1(super.data, {super.key, super.style}) : super(semanticsLabel: 'H1');

  @override
  TextStyle buildTextStyle(BuildContext context) {
    return DefaultTextStyle.of(context)
        .style
        .copyWith(fontSize: 2.rem, fontWeight: FontUtil.bold)
        .applyForceTextStyle
        .merge(style);
  }
}

class H2 extends TextWidget {
  /// 二级标题
  const H2(super.data, {super.key, super.style}) : super(semanticsLabel: 'H2');

  @override
  TextStyle buildTextStyle(BuildContext context) {
    return DefaultTextStyle.of(context)
        .style
        .copyWith(fontSize: 1.5.rem, fontWeight: FontUtil.bold)
        .applyForceTextStyle
        .merge(style);
  }
}

class H3 extends TextWidget {
  /// 三级标题
  const H3(super.data, {super.key, super.style}) : super(semanticsLabel: 'H3');

  @override
  TextStyle buildTextStyle(BuildContext context) {
    return DefaultTextStyle.of(context)
        .style
        .copyWith(fontSize: 1.25.rem, fontWeight: FontUtil.bold)
        .applyForceTextStyle
        .merge(style);
  }
}

class H4 extends TextWidget {
  /// 四级标题
  const H4(super.data, {super.key, super.style}) : super(semanticsLabel: 'H4');

  @override
  TextStyle buildTextStyle(BuildContext context) {
    return DefaultTextStyle.of(context)
        .style
        .copyWith(fontSize: 1.17.rem, fontWeight: FontUtil.bold)
        .applyForceTextStyle
        .merge(style);
  }
}

class H5 extends TextWidget {
  /// 五级标题
  const H5(super.data, {super.key, super.style}) : super(semanticsLabel: 'H5');

  @override
  TextStyle buildTextStyle(BuildContext context) {
    return DefaultTextStyle.of(context)
        .style
        .copyWith(fontSize: 1.rem, fontWeight: FontUtil.bold)
        .applyForceTextStyle
        .merge(style);
  }
}

class H6 extends TextWidget {
  /// 六级标题
  const H6(super.data, {super.key, super.style}) : super(semanticsLabel: 'H6');

  @override
  TextStyle buildTextStyle(BuildContext context) {
    return DefaultTextStyle.of(context)
        .style
        .copyWith(fontSize: 0.875.rem, fontWeight: FontUtil.bold)
        .applyForceTextStyle
        .merge(style);
  }
}
