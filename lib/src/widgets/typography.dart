import 'package:flutter/widgets.dart';
import 'package:luoyi_flutter_base/luoyi_flutter_base.dart';
import 'package:url_launcher/url_launcher.dart';

const double _h1FontSize = 28;
const double _h2FontSize = 24;
const double _h3FontSize = 20;
const double _h4FontSize = 18;
const double _h5FontSize = 16;
const double _h6FontSize = 14;
const double _normalFontSize = 15;

/// 字体排版抽象类
abstract class _Typography extends StatelessWidget {
  const _Typography(
    this.data, {
    super.key,
    this.size,
    this.color,
    this.weight,
    this.underline = false,
    this.italic = false,
  });

  /// * 如果是[List]，则当做富文本渲染；
  /// * 最后一律自动渲染为[Text]
  final dynamic data;

  /// 字体尺寸
  final double? size;

  /// 文字颜色
  final Color? color;

  /// 文字字重
  final FontWeight? weight;

  /// 文字下划线
  final bool underline;

  /// 文本倾斜
  final bool italic;

  Widget buildTypography(
    BuildContext context, {
    double? size,
    Color? color,
    FontWeight? weight,
  }) {
    TextStyle style = TextStyle(
      fontSize: size,
      color: color,
      fontWeight: weight,
    );
    if (underline) {
      style = style.copyWith(decoration: TextDecoration.underline);
    }
    if (italic) {
      style = style.copyWith(fontStyle: FontStyle.italic);
    }
    return DefaultTextStyle.merge(
      style: style,
      child: data is List
          ? Wrap(
              crossAxisAlignment: WrapCrossAlignment.center,
              children: (data as List).map((e) {
                if (e is Widget) return e;
                return Text('$e');
              }).toList(),
            )
          : Text('$data'),
    );
  }
}

/// 渲染标题类型文字
abstract class _Title extends _Typography {
  const _Title(super.data, {super.key, super.size, super.color});

  Widget buildTitle(
    BuildContext context, {
    required double size,
    Color? color,
  }) {
    return buildTypography(
      context,
      size: size,
      color: color,
      weight: FontUtil.bold,
    );
  }
}

/// 渲染普通类型文字
abstract class _Text extends _Typography {
  const _Text(
    super.data, {
    super.key,
    super.size,
    super.color,
    super.weight,
    super.underline,
    super.italic,
  });

  Widget buildText(
    BuildContext context, {
    required double size,
    Color? color,
    FontWeight? weight,
  }) {
    return buildTypography(
      context,
      size: size,
      color: color,
      weight: weight ?? FontUtil.normal,
    );
  }
}

/// 一级标题
class H1 extends _Title {
  const H1(super.data, {super.key, super.size, super.color});

  @override
  Widget build(BuildContext context) {
    return buildTitle(context, size: size ?? _h1FontSize, color: color);
  }
}

/// 二级标题
class H2 extends _Title {
  const H2(super.data, {super.key, super.size, super.color});

  @override
  Widget build(BuildContext context) {
    return buildTitle(context, size: size ?? _h2FontSize, color: color);
  }
}

/// 三级标题
class H3 extends _Title {
  const H3(super.data, {super.key, super.size, super.color});

  @override
  Widget build(BuildContext context) {
    return buildTitle(context, size: size ?? _h3FontSize, color: color);
  }
}

/// 四级标题
class H4 extends _Title {
  const H4(super.data, {super.key, super.size, super.color});

  @override
  Widget build(BuildContext context) {
    return buildTitle(context, size: size ?? _h4FontSize, color: color);
  }
}

/// 五级标题
class H5 extends _Title {
  const H5(super.data, {super.key, super.size, super.color});

  @override
  Widget build(BuildContext context) {
    return buildTitle(context, size: size ?? _h5FontSize, color: color);
  }
}

/// 六级标题
class H6 extends _Title {
  const H6(super.data, {super.key, super.size, super.color});

  @override
  Widget build(BuildContext context) {
    return buildTitle(context, size: size ?? _h6FontSize, color: color);
  }
}

/// 普通段落文本
class P extends _Text {
  const P(
    super.data, {
    super.key,
    super.size,
    super.color,
    super.weight,
    super.underline,
    super.italic,
  });

  @override
  Widget build(BuildContext context) {
    return buildText(
      context,
      size: size ?? _normalFontSize,
      color: color,
      weight: weight,
    );
  }
}

/// 超链接
class A extends _Text {
  const A(
    super.data, {
    super.key,
    super.size,
    super.color,
    super.weight,
    this.href,
    super.underline = true,
    super.italic,
  });

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
          return buildText(
            context,
            size: size ?? _normalFontSize,
            color: $color
                .onHover(isHover, $color.deepen(20))
                .onTap(isTap, $color.deepen(50)),
            weight: weight,
          );
        },
      );
    });
  }
}

/// 加粗文本
class B extends _Text {
  const B(
    super.data, {
    super.key,
    super.size,
    super.color,
    super.italic,
    super.underline,
  });

  @override
  Widget build(BuildContext context) {
    return buildText(
      context,
      size: size ?? _normalFontSize,
      color: color,
      weight: FontUtil.bold,
    );
  }
}

/// 斜体文本
class I extends _Text {
  const I(
    super.data, {
    super.key,
    super.size,
    super.color,
    super.weight,
    super.underline,
  }) : super(italic: true);

  @override
  Widget build(BuildContext context) {
    return buildText(
      context,
      size: size ?? _normalFontSize,
      color: color,
      weight: weight,
    );
  }
}
