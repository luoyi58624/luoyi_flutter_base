import 'package:flutter/widgets.dart';
import 'package:luoyi_flutter_base/src/widgets/brightness.dart';

import '../utils/font/font.dart';

/// 文字排版模型对象
class TypographyModel {
  /// 标题颜色
  final Color titleColor;
  final Color titleDarkColor;

  /// 普通文本颜色
  final Color textColor;
  final Color textDarkColor;

  /// 超链接文字颜色
  final Color hrefColor;
  final Color hrefDarkColor;

  /// 各种类型文本尺寸大小
  final double h1;
  final double h2;
  final double h3;
  final double h4;
  final double h5;
  final double h6;
  final double p;

  const TypographyModel({
    this.titleColor = const Color(0xff181818),
    this.titleDarkColor = const Color(0xfffafafa),
    this.textColor = const Color(0xff222222),
    this.textDarkColor = const Color(0xfff2f2f2),
    this.hrefColor = const Color(0xff0ea5e9),
    this.hrefDarkColor = const Color(0xff0284c7),
    this.h1 = 28,
    this.h2 = 24,
    this.h3 = 20,
    this.h4 = 18,
    this.h5 = 16,
    this.h6 = 14,
    this.p = 16,
  });
}

/// 配置全局的文字样式
class TypographyInheritedWidget extends InheritedWidget {
  const TypographyInheritedWidget({
    super.key,
    required super.child,
    required this.model,
  });

  final TypographyModel model;

  static TypographyModel of(BuildContext context) {
    return context
            .dependOnInheritedWidgetOfExactType<TypographyInheritedWidget>()
            ?.model ??
        const TypographyModel();
  }

  @override
  bool updateShouldNotify(TypographyInheritedWidget oldWidget) => true;
}

/// 字体排版抽象类，这里只声明文字通用的属性
abstract class _Typography extends StatelessWidget {
  const _Typography(
    this.data, {
    super.key,
    this.size,
    this.color,
    this.weight,
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

  Widget buildTypography(
    BuildContext context,
    double size,
    Color color,
    FontWeight weight,
  ) {
    return DefaultTextStyle.merge(
      style: TextStyle(fontSize: size, color: color, fontWeight: weight),
      child: data is List<Widget>
          ? Wrap(
              children: data,
              crossAxisAlignment: WrapCrossAlignment.center,
            )
          : Text('$data'),
    );
  }
}

/// 渲染标题类型文字
abstract class _Title extends _Typography {
  const _Title(super.data, {super.key, super.size, super.color, super.weight});

  Widget buildTitle(
    BuildContext context, {
    required double size,
    Color? color,
  }) {
    final model = TypographyInheritedWidget.of(context);
    final $color =
        color ?? (context.isDark ? model.titleDarkColor : model.titleColor);
    return buildTypography(context, size, $color, FontUtil.bold);
  }
}

/// 渲染普通类型文字
abstract class _Text extends _Typography {
  const _Text(super.data, {super.key, super.size, super.color, super.weight});

  Widget buildText(
    BuildContext context, {
    required double size,
    Color? color,
    FontWeight? weight,
  }) {
    final model = TypographyInheritedWidget.of(context);
    final $color =
        color ?? (context.isDark ? model.textDarkColor : model.textColor);
    return buildTypography(context, size, $color, weight ?? FontUtil.normal);
  }
}

/// 一级标题
class H1 extends _Title {
  const H1(super.data, {super.key, super.size, super.color});

  @override
  Widget build(BuildContext context) {
    final model = TypographyInheritedWidget.of(context);
    return buildTitle(context, size: size ?? model.h1, color: color);
  }
}

/// 二级标题
class H2 extends _Title {
  const H2(super.data, {super.key, super.size, super.color});

  @override
  Widget build(BuildContext context) {
    final model = TypographyInheritedWidget.of(context);
    return buildTitle(context, size: size ?? model.h2, color: color);
  }
}

/// 三级标题
class H3 extends _Title {
  const H3(super.data, {super.key, super.size, super.color});

  @override
  Widget build(BuildContext context) {
    final model = TypographyInheritedWidget.of(context);
    return buildTitle(context, size: size ?? model.h3, color: color);
  }
}

/// 四级标题
class H4 extends _Title {
  const H4(super.data, {super.key, super.size, super.color});

  @override
  Widget build(BuildContext context) {
    final model = TypographyInheritedWidget.of(context);
    return buildTitle(context, size: size ?? model.h4, color: color);
  }
}

/// 五级标题
class H5 extends _Title {
  const H5(super.data, {super.key, super.size, super.color});

  @override
  Widget build(BuildContext context) {
    final model = TypographyInheritedWidget.of(context);
    return buildTitle(context, size: size ?? model.h5, color: color);
  }
}

/// 六级标题
class H6 extends _Title {
  const H6(super.data, {super.key, super.size, super.color});

  @override
  Widget build(BuildContext context) {
    final model = TypographyInheritedWidget.of(context);
    return buildTitle(context, size: size ?? model.h6, color: color);
  }
}

/// 普通段落文本
class P extends _Text {
  const P(super.data, {super.key, super.size, super.color, super.weight});

  @override
  Widget build(BuildContext context) {
    final model = TypographyInheritedWidget.of(context);
    return buildText(
      context,
      size: size ?? model.p,
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
    this.underline = true,
  });

  /// 是否显示下划线
  final bool underline;

  @override
  Widget build(BuildContext context) {
    final model = TypographyInheritedWidget.of(context);
    final $color =
        color ?? (context.isDark ? model.hrefDarkColor : model.hrefColor);
    return Stack(
      children: [
        buildText(
          context,
          size: size ?? model.p,
          color: $color,
          weight: weight,
        ),
        if (underline)
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(height: 0.8, color: $color),
          )
      ],
    );
  }
}

/// 加粗文本
class B extends _Text {
  const B(super.data, {super.key, super.size, super.color});

  @override
  Widget build(BuildContext context) {
    final model = TypographyInheritedWidget.of(context);
    return buildText(
      context,
      size: size ?? model.p,
      color: color,
      weight: FontUtil.bold,
    );
  }
}
