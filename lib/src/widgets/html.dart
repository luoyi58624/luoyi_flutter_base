import 'package:flutter/widgets.dart';
import 'package:luoyi_flutter_base/luoyi_flutter_base.dart';
import 'package:url_launcher/url_launcher.dart';

const double _h1FontSize = 24;
const double _h2FontSize = 20;
const double _h3FontSize = 18;
const double _h4FontSize = 16;
const double _h5FontSize = 14;
const double _h6FontSize = 12;
const double _normalFontSize = 15;

/// 字体排版小部件抽象类，对[Text]进行封装，主要支持2个功能：
/// 1. [data]支持任意内容，如果是[List]，则使用[Wrap]进行包裹，输出渲染可以当做富文本
/// 2. [data]如果是[Widget]类型，则直接渲染，否则自动转换成[Text]
abstract class TypographyWidget extends StatelessWidget {
  const TypographyWidget(
    this.data, {
    super.key,
    this.style,
    this.strutStyle,
    this.textAlign,
    this.textDirection,
    this.locale,
    this.softWrap,
    this.overflow,
    this.textScaler,
    this.maxLines,
    this.semanticsLabel,
    this.textWidthBasis,
    this.textHeightBehavior,
    this.selectionColor,
  });

  /// * 如果是[List]，则当做富文本渲染；
  /// * 最后一律自动渲染为[Text]
  final dynamic data;

  // ===========================================================================
  // 以下所有属性均为 Text、DefaultTextStyle 自带的属性，为了兼顾最高灵活性，
  // 优先对 DefaultTextStyle 支持的属性进行合并，再将剩余的属性直接设置到 Text 小部件。
  // ===========================================================================
  final TextStyle? style;
  final StrutStyle? strutStyle;
  final TextAlign? textAlign;
  final TextDirection? textDirection;
  final Locale? locale;
  final bool? softWrap;
  final TextOverflow? overflow;
  final TextScaler? textScaler;
  final int? maxLines;
  final String? semanticsLabel;
  final TextWidthBasis? textWidthBasis;
  final TextHeightBehavior? textHeightBehavior;
  final Color? selectionColor;

  Widget buildTypography(BuildContext context, TextStyle typographyStyle) {
    return DefaultTextStyle.merge(
      style: typographyStyle.merge(style),
      textAlign: textAlign,
      softWrap: softWrap,
      overflow: overflow,
      maxLines: maxLines,
      textWidthBasis: textWidthBasis,
      child: _build(),
    );
  }

  Widget _build() {
    if (data is List) {
      return Wrap(
        crossAxisAlignment: WrapCrossAlignment.center,
        children: (data as List).map((e) {
          if (e is Widget) return e;
          return _buildRichText(e);
        }).toList(),
      );
    } else {
      return _buildText();
    }
  }

  Widget _buildRichText(dynamic data) {
    return Text(
      '$data',
      strutStyle: strutStyle,
      textDirection: textDirection,
      locale: locale,
      textScaler: textScaler,
      semanticsLabel: semanticsLabel,
      textHeightBehavior: textHeightBehavior,
      selectionColor: selectionColor,
    );
  }

  Widget _buildText() {
    return Text(
      '$data',
      strutStyle: strutStyle,
      textDirection: textDirection,
      locale: locale,
      textScaler: textScaler,
      semanticsLabel: semanticsLabel,
      textHeightBehavior: textHeightBehavior,
      selectionColor: selectionColor,
    );
  }
}

/// 一级标题
class H1 extends TypographyWidget {
  const H1(super.data, {super.key, super.style}) : super(semanticsLabel: 'H1');

  @override
  Widget build(BuildContext context) {
    return buildTypography(
      context,
      const TextStyle(
        fontSize: _h1FontSize,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}

/// 二级标题
class H2 extends TypographyWidget {
  const H2(super.data, {super.key, super.style}) : super(semanticsLabel: 'H2');

  @override
  Widget build(BuildContext context) {
    return buildTypography(
      context,
      const TextStyle(
        fontSize: _h2FontSize,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}

/// 三级标题
class H3 extends TypographyWidget {
  const H3(super.data, {super.key, super.style}) : super(semanticsLabel: 'H3');

  @override
  Widget build(BuildContext context) {
    return buildTypography(
      context,
      const TextStyle(
        fontSize: _h3FontSize,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}

/// 四级标题
class H4 extends TypographyWidget {
  const H4(super.data, {super.key, super.style}) : super(semanticsLabel: 'H4');

  @override
  Widget build(BuildContext context) {
    return buildTypography(
      context,
      const TextStyle(
        fontSize: _h4FontSize,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}

/// 五级标题
class H5 extends TypographyWidget {
  const H5(super.data, {super.key, super.style}) : super(semanticsLabel: 'H5');

  @override
  Widget build(BuildContext context) {
    return buildTypography(
      context,
      const TextStyle(
        fontSize: _h5FontSize,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}

/// 六级标题
class H6 extends TypographyWidget {
  const H6(super.data, {super.key, super.style}) : super(semanticsLabel: 'H6');

  @override
  Widget build(BuildContext context) {
    return buildTypography(
      context,
      const TextStyle(
        fontSize: _h6FontSize,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}

/// 内联标签
class Span extends TypographyWidget {
  const Span(super.data, {super.key, super.style}) : super(semanticsLabel: 'P');

  @override
  Widget build(BuildContext context) {
    return buildTypography(
      context,
      const TextStyle(fontSize: _normalFontSize),
    );
  }
}

/// 段落标签
class P extends TypographyWidget {
  const P(super.data, {super.key, super.style}) : super(semanticsLabel: 'P');

  @override
  Widget build(BuildContext context) {
    return buildTypography(
      context,
      const TextStyle(
        fontSize: _normalFontSize,
        fontWeight: FontWeight.normal,
      ),
    );
  }
}

/// 超链接
class A extends TypographyWidget {
  const A(
    super.data, {
    super.key,
    super.style,
    this.color,
    this.href,
  }) : super(semanticsLabel: 'A');

  /// 自定义文字颜色
  final Color? color;

  /// 跳转目标地址
  final String? href;

  @override
  Widget build(BuildContext context) {
    final $color = color ?? const Color(0xff409eff);
    return HoverBuilder(builder: (isHover) {
      return TapBuilder(
        onTap: href == null
            ? null
            : () {
                launchUrl(Uri.parse(href!));
              },
        builder: (isTap) {
          final $$color = $color.onTap(isTap, $color.deepen(30));
          return buildTypography(
            context,
            TextStyle(
              fontSize: _normalFontSize,
              color: $$color,
              decoration:
                  isHover ? TextDecoration.underline : TextDecoration.none,
              decorationColor: $$color,
            ),
          );
        },
      );
    });
  }
}

/// 加粗文本
class B extends TypographyWidget {
  const B(super.data, {super.key, super.style}) : super(semanticsLabel: 'B');

  @override
  Widget build(BuildContext context) {
    return buildTypography(
      context,
      TextStyle(
        fontSize: _normalFontSize,
        fontWeight: FontUtil.bold,
      ),
    );
  }
}

/// 斜体文本
class I extends TypographyWidget {
  const I(
    super.data, {
    super.key,
    super.style,
  }) : super(semanticsLabel: 'I');

  @override
  Widget build(BuildContext context) {
    return buildTypography(
      context,
      const TextStyle(
        fontSize: _normalFontSize,
        fontStyle: FontStyle.italic,
      ),
    );
  }
}
