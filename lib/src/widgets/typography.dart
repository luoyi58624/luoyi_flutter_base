import 'package:flutter/widgets.dart';
import 'package:luoyi_flutter_base/src/widgets/brightness.dart';

import '../utils/font/font.dart';

/// 文字排版模型对象
class TypographyModel {
  final Color titleColor;
  final Color titleDarkColor;
  final Color textColor;
  final Color textDarkColor;
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

abstract class _Typography extends StatelessWidget {
  const _Typography(
    this.text, {
    super.key,
    this.size,
    this.color,
    this.weight,
  });

  final dynamic text;
  final double? size;
  final Color? color;
  final FontWeight? weight;

  Widget buildText(
    BuildContext context,
    double size,
    Color color,
    FontWeight weight,
  ) {
    if (text is Widget) return text;
    if (text is List) {
      return Text.rich(TextSpan());
    }
    return Text(
      '$text',
      style: TextStyle(
        fontSize: size,
        color: color,
      ),
    );
  }
}

class H1 extends _Typography {
  const H1(
    super.text, {
    super.key,
    super.size,
    super.color,
    super.weight = FontWeight.bold,
  });

  @override
  Widget build(BuildContext context) {
    final model = TypographyInheritedWidget.of(context);
    return buildText(
      context,
      size ?? model.h1,
      color ?? (context.isDark ? model.titleDarkColor : model.titleColor),
      FontUtil.bold,
    );
  }
}

class H2 extends _Typography {
  const H2(
    super.text, {
    super.key,
    super.size,
    super.color,
    super.weight = FontWeight.bold,
  });

  @override
  Widget build(BuildContext context) {
    final model = TypographyInheritedWidget.of(context);
    return buildText(
      context,
      size ?? model.h2,
      color ?? (context.isDark ? model.titleDarkColor : model.titleColor),
      FontUtil.bold,
    );
  }
}

class P extends _Typography {
  const P(super.text, {super.key, super.size, super.color});

  @override
  Widget build(BuildContext context) {
    final model = TypographyInheritedWidget.of(context);
    return buildText(
      context,
      size ?? model.p,
      color ?? (context.isDark ? model.textDarkColor : model.textColor),
      FontUtil.normal,
    );
  }
}
