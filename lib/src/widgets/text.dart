import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:luoyi_flutter_base/src/extensions/private.dart';

import '../commons/global.dart';
import 'hover.dart';

/// 文本组件，与 [Text] 相比，简化了富文本的写法
class TextWidget extends StatelessWidget {
  const TextWidget(
    this.data, {
    super.key,
    this.style,
    this.strutStyle,
    this.textAlign,
    this.textDirection,
    this.locale,
    this.softWrap = true,
    this.overflow,
    this.textScaler,
    this.maxLines,
    this.semanticsLabel = 'Text',
    this.textWidthBasis,
    this.textHeightBehavior,
    this.selectionColor,
  });

  /// 渲染的文本内容，支持传递任意小部件，如果是[List]集合，则会渲染成富文本。
  ///
  /// 对于富文本，如果传递的类型并非基础数据类型或者 [TextWidget] 类型，
  /// 那么将自动使用 [WidgetSpan] 进行包裹，为了能够垂直对齐文本，
  /// [WidgetSpan]设置了特定的 alignment、baseline 属性，
  /// 这些默认值对于非文本小部件的垂直对齐效果不好，
  /// 但你可以自己在外面包裹 [WidgetSpan] 调整定位。
  final dynamic data;

  /// 文本样式
  final TextStyle? style;

  /// 文本基线对齐样式
  final StrutStyle? strutStyle;

  /// 文本水平对齐方式，默认左对齐
  final TextAlign? textAlign;

  /// 控制文本方向：ltr、rtl
  final TextDirection? textDirection;

  /// 指定语言
  final Locale? locale;

  /// 是否自动换行
  final bool softWrap;

  /// 文本超出样式
  final TextOverflow? overflow;

  /// 文本缩放倍数，如果要放大2倍，设置 TextScaler.linear(2) 即可
  final TextScaler? textScaler;

  /// 文本最大行数，即使你设置[softWrap]为false，该属性也能生效
  final int? maxLines;

  /// 语义化标签
  final String? semanticsLabel;
  final TextWidthBasis? textWidthBasis;
  final TextHeightBehavior? textHeightBehavior;

  /// 文本选中颜色
  final Color? selectionColor;

  /// 构建当前文本样式
  TextStyle buildTextStyle(BuildContext context) {
    return GlobalConfig.textStyle
        .merge(DefaultTextStyle.of(context).style)
        .applyForceTextStyle
        .merge(style);
  }

  /// 构建文本小部件
  @override
  Widget build(BuildContext context) {
    var $style = buildTextStyle(context).copyWith();
    // 同步 Text 小部件的加粗文本逻辑
    if (MediaQuery.boldTextOf(context)) {
      $style.copyWith(fontWeight: FontWeight.bold);
    }
    final SelectionRegistrar? registrar = SelectionContainer.maybeOf(context);
    return HoverBuilder(
        onlyCursor: true,
        cursor: registrar == null
            ? null
            : DefaultSelectionStyle.of(context).mouseCursor ??
                HoverBuilder.mouseCursor(context) ??
                SystemMouseCursors.text,
        builder: (context) {
          return DefaultTextStyle.merge(
            style: $style,
            textAlign: textAlign,
            softWrap: softWrap,
            overflow: overflow,
            maxLines: maxLines,
            child: Builder(builder: (context) {
              final $defaultStyle = DefaultTextStyle.of(context);
              return RichText(
                text: TextSpan(
                  style: $defaultStyle.style,
                  children:
                      _buildRichText(context, data is List ? data : [data]),
                ),
                textAlign: $defaultStyle.textAlign ?? TextAlign.start,
                textDirection: textDirection,
                softWrap: $defaultStyle.softWrap,
                overflow: $defaultStyle.overflow,
                textScaler: textScaler ?? TextScaler.noScaling,
                maxLines: $defaultStyle.maxLines,
                locale: locale,
                strutStyle: strutStyle,
                textWidthBasis: $defaultStyle.textWidthBasis,
                textHeightBehavior: textHeightBehavior,
                selectionRegistrar: registrar,
                selectionColor: selectionColor ??
                    DefaultSelectionStyle.of(context).selectionColor ??
                    DefaultSelectionStyle.defaultColor,
              );
            }),
          );
        });
  }

  /// 构建富文本片段集合
  List<InlineSpan> _buildRichText(BuildContext context, List children) {
    List<InlineSpan> richChildren = [];
    for (final child in children) {
      richChildren.add(_buildInlineSpan(context, child));
    }
    return richChildren;
  }

  /// 使用递归构建富文本片段
  InlineSpan _buildInlineSpan(BuildContext context, dynamic data) {
    // 1. 如果是文本片段则直接返回
    if (data is TextSpan || data is WidgetSpan) return data;

    // 2. 如果是 Widget 小部件，则使用 WidgetSpan 包裹，默认使用文本对齐方案，
    // 如果你传递的 Widget 不是文本，你可以包裹 WidgetSpan 自定义对齐
    if (data is Widget) {
      return WidgetSpan(
        alignment: PlaceholderAlignment.baseline,
        baseline: TextBaseline.alphabetic,
        child: data,
      );
    }

    // 3. 如果是数组，则递归渲染
    if (data is List) {
      return TextSpan(
        children: _buildRichText(context, data),
      );
    }

    // 4. 默认返回文本片段
    return TextSpan(
      text: '$data',
      semanticsLabel: semanticsLabel,
    );
  }
}
