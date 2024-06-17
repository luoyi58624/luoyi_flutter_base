import 'package:flutter/widgets.dart';

class Style {
  /// element width
  final double? width;

  /// element height
  final double? height;

  /// element background color
  final Color? backgroundColor;

  /// element text color
  final Color? color;

  /// element padding：
  /// 1. [10] - all
  /// 2. [10, 20] - vertical、horizontal
  /// 3. [10, 20, 10, 20] - top、right、bottom、left
  final List<double>? padding;

  /// element margin：
  /// 1. [10] - all
  /// 2. [10, 20] - vertical、horizontal
  /// 3. [10, 20, 10, 20] - top、right、bottom、left
  final List<double>? margin;

  /// element border width
  final double? borderWidth;

  /// element child alignment
  final AlignmentGeometry? alignment;

  const Style({
    this.width,
    this.height,
    this.backgroundColor,
    this.color,
    this.padding,
    this.margin,
    this.borderWidth,
    this.alignment,
  });
}
