import 'package:flutter/widgets.dart';

import 'global.dart';

extension FlutterResponsiveExtension on BuildContext {
  /// 应用可视宽度
  double get clientWidth => MediaQuery.sizeOf(this).width;

  /// 极小设备，最大宽度默认320
  bool get xs => clientWidth <= GlobalConfig.responsive.xs;

  /// 移动端设备，最大宽度默认640
  bool get sm => clientWidth <= GlobalConfig.responsive.sm;

  /// 平板设备，最大宽度默认1024
  bool get md => clientWidth <= GlobalConfig.responsive.md;

  /// 桌面设备，最大宽度默认1920
  bool get lg => clientWidth <= GlobalConfig.responsive.lg;

  /// 大屏桌面设备，最大宽度默认2560
  bool get xl => clientWidth <= GlobalConfig.responsive.xl;
}

/// 响应式配置
class ResponsiveData {
  /// 特小号设备最大尺寸
  final double xs;

  /// 移动设备最大尺寸
  final double sm;

  /// 平板设备最大尺寸
  final double md;

  /// 桌面设备最大尺寸
  final double lg;

  /// 大屏桌面设备最大尺寸
  final double xl;

  const ResponsiveData({
    this.xs = 320,
    this.sm = 640,
    this.md = 1024,
    this.lg = 1920,
    this.xl = 2560,
  });

  ResponsiveData copyWith({
    double? xs,
    double? sm,
    double? md,
    double? lg,
    double? xl,
  }) {
    return ResponsiveData(
      xs: xs ?? this.xs,
      sm: sm ?? this.sm,
      md: md ?? this.md,
      lg: lg ?? this.lg,
      xl: xl ?? this.xl,
    );
  }
}
