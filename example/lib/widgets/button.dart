import 'package:flutter/material.dart';
import 'package:luoyi_flutter_base/luoyi_flutter_base.dart';

class MyButton extends BaseButton {
  const MyButton({
    super.key,
    required super.onPressed,
    required super.child,
    super.color,
  });

  @override
  Widget build(BuildContext context) {
    return super.build(context);
  }
}

abstract class BaseButton extends HookWidget {
  const BaseButton({
    super.key,
    required this.onPressed,
    required this.child,
    this.backgroundColor = const Color(0xfff3f4f6),
    this.color,
    this.margin = const EdgeInsets.all(4),
    this.padding = const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
    this.border,
    this.borderRadius,
    this.gradient,
    this.shape = BoxShape.rectangle,
  });

  /// 按钮点击事件
  final GestureTapCallback? onPressed;

  /// 按钮子元素
  final Widget child;

  /// 按钮背景颜色
  final Color backgroundColor;

  /// 按钮文字颜色，默认根据[backgroundColor]自动计算白色和黑色
  final Color? color;

  /// 外边距
  final EdgeInsets margin;

  /// 内边距
  final EdgeInsets padding;

  /// 按钮边框
  final BoxBorder? border;

  /// 按钮边框圆角
  final BorderRadiusGeometry? borderRadius;

  /// 渐变背景色
  final Gradient? gradient;

  final BoxShape shape;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: margin,
      child: HoverBuilder(
        onlyCursor: true,
        disabled: onPressed == null,
        builder: (isHover) {
          return TapBuilder(
            onTap: onPressed,
            disabled: onPressed == null,
            builder: (isTap) {
              return DecoratedBox(
                decoration: BoxDecoration(
                  color: backgroundColor.onTap(isTap),
                  border: border,
                  borderRadius: borderRadius ?? BorderRadius.circular(context.appConfig.buttonRadius),
                  gradient: gradient,
                  shape: shape,
                ),
                child: Padding(
                  padding: padding,
                  child: DefaultTextStyle(
                    style: TextStyle(
                      fontFamily: context.appConfig.fontFamily,
                      color: color ??
                          (backgroundColor.isDark
                              ? AppThemeWidget.darkTheme(context).textColor
                              : AppThemeWidget.theme(context).textColor),
                      fontWeight: FontWeight.w500,
                    ),
                    child: child,
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
