import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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

class _TypeSegmentRecord {
  final bool isText;
  (int, int) section;

  _TypeSegmentRecord(this.isText, this.section);

  @override
  String toString() {
    return '_TypeSegmentRecord{isText: $isText, section: $section}';
  }
}

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

  bool get isMultiNode => data is List;

  Widget buildTypography(BuildContext context, TextStyle typographyStyle) {
    return DefaultTextStyle.merge(
      style: typographyStyle.merge(style),
      textAlign: textAlign,
      softWrap: softWrap,
      overflow: overflow,
      maxLines: maxLines,
      textWidthBasis: textWidthBasis,
      child: isMultiNode
          ? Builder(builder: (context) {
              return RichText(
                  text: TextSpan(
                style: DefaultTextStyle.of(context).style,
                children: _buildRichText(data),
              ));
            })
          : _buildText(),
    );
  }

  Widget _build(BuildContext context) {
    if (data is List) {
      List $data = data;
      List<Widget> children = [];
      // 分段记录数组类型
      List<_TypeSegmentRecord> typeSegmentRecords = [];

      // 填充富文本类型分段数据，对连续的文本、其他widget进行分组
      for (int i = 0; i < $data.length; i++) {
        var childData = $data[i];
        if (DartUtil.isBaseType(childData) ||
            childData is TypographyWidget ||
            childData is Text ||
            childData is RichText ||
            childData is TextSpan) {
          if (typeSegmentRecords.isEmpty) {
            typeSegmentRecords.add(_TypeSegmentRecord(true, (i, i)));
          } else {
            if (typeSegmentRecords.last.isText) {
              typeSegmentRecords[typeSegmentRecords.length - 1] =
                  _TypeSegmentRecord(true, (
                typeSegmentRecords.last.section.$1,
                typeSegmentRecords.last.section.$2 + 1
              ));
            } else {
              typeSegmentRecords.add(_TypeSegmentRecord(true, (i, i)));
            }
          }
        } else {
          typeSegmentRecords.add(_TypeSegmentRecord(false, (i, i)));
        }
      }
      i(typeSegmentRecords);
      // 将划分好的类型数据转换成文本、富文本、以及其他widget
      for (var typeData in typeSegmentRecords) {
        if (typeData.isText) {
          List<TextSpan> richTextChildren = [];
          for (int i = typeData.section.$1 + 1; i <= typeData.section.$2; i++) {
            if (DartUtil.isBaseType(data[i])) {
              richTextChildren.add(TextSpan(text: data[i]));
            } else if (data[i] is TypographyWidget) {
              final $data = (data[i] as TypographyWidget);
              richTextChildren.add(
                TextSpan(
                  text: $data.data,
                  style: $data.style,
                ),
              );
            }
          }
          children.add(_buildFirstTextSpan(
            context,
            data[typeData.section.$1],
            richTextChildren,
          ));
        } else {
          children.add(data[typeData.section.$1]);
        }
      }
      return Wrap(
        crossAxisAlignment: WrapCrossAlignment.center,
        children: children,
      );
    } else {
      return _buildText();
    }
  }

  RichText _buildFirstTextSpan(BuildContext context, dynamic data,
      [List<TextSpan>? children]) {
    final style = DefaultTextStyle.of(context).style;
    if (DartUtil.isBaseType(data)) {
      return RichText(
        text: TextSpan(
          text: '$data',
          style: style,
          children: children,
        ),
      );
    } else if (data is TypographyWidget) {
      return RichText(
        text: TextSpan(
          text: data.data.toString(),
          style: data.style,
          children: children,
        ),
      );
    } else if (data is Text) {
      return RichText(
        text: TextSpan(
          text: data.data,
          style: style,
          children: children,
        ),
      );
    } else if (data is RichText) {
      return data;
    } else if (data is TextSpan) {
      return RichText(text: data);
    } else {
      throw '_buildFirstTextSpan exception';
    }
  }

  List<InlineSpan> _buildRichText(List children) {
    List<InlineSpan> richChildren = [];
    for (final child in children) {
      if (DartUtil.isBaseType(child)) {
        richChildren.add(TextSpan(text: '$child'));
      } else if (child is TypographyWidget) {
        if (child.isMultiNode) {
        } else {
          richChildren.add(TextSpan(text: '${child.data}', style: child.style));
        }
      } else {
        richChildren.add(WidgetSpan(child: child));
      }
    }
    return richChildren;
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
// class Span extends TypographyWidget {
//   const Span(super.data, {super.key, super.style}) : super(semanticsLabel: 'P');
//
//   @override
//   Widget build(BuildContext context) {
//     return buildTypography(
//       context,
//       const TextStyle(fontSize: _normalFontSize),
//     );
//   }
// }

/// 段落标签
class Span extends TypographyWidget {
  /// 构建一段文本
  const Span(super.data, {super.key, super.style}) : super(semanticsLabel: 'P');

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
