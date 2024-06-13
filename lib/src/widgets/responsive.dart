import 'package:flutter/widgets.dart';

class ResponsiveData {
  /// 手机最大尺寸
  final double sm;

  /// 平板最大尺寸
  final double md;

  /// 桌面最大尺寸
  final double lg;

  /// 大屏桌面最大尺寸
  final double xl;

  const ResponsiveData({
    this.sm = 640,
    this.md = 1024,
    this.lg = 1920,
    this.xl = 2560,
  });

  ResponsiveData copyWith({
    double? sm,
    double? md,
    double? lg,
    double? xl,
  }) {
    return ResponsiveData(
      sm: sm ?? this.sm,
      md: md ?? this.md,
      lg: lg ?? this.lg,
      xl: xl ?? this.xl,
    );
  }
}

extension ElResponsiveExtension on BuildContext {
  /// 移动端设备
  bool get sm => MediaQuery.sizeOf(this).width < ResponsiveWidget.of(this).sm;

  /// 平板设备
  bool get md => MediaQuery.sizeOf(this).width < ResponsiveWidget.of(this).md;

  /// 桌面设备
  bool get lg => MediaQuery.sizeOf(this).width < ResponsiveWidget.of(this).lg;

  /// 大屏桌面设备
  bool get xl => MediaQuery.sizeOf(this).width < ResponsiveWidget.of(this).xl;
}

class ResponsiveWidget extends InheritedWidget {
  const ResponsiveWidget({
    super.key,
    required super.child,
    required this.data,
  });

  final ResponsiveData data;

  static ResponsiveData of(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<ResponsiveWidget>()?.data ??
      const ResponsiveData();

  @override
  bool updateShouldNotify(ResponsiveWidget oldWidget) => false;
}
