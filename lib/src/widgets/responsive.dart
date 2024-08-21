import 'package:flutter/widgets.dart';

extension FlutterResponsiveExtension on BuildContext {
  /// 极小设备，最大宽度默认320
  bool get xs => MediaQuery.sizeOf(this).width <= ResponsiveWidget.of(this).xs;

  /// 移动端设备，最大宽度默认640
  bool get sm => MediaQuery.sizeOf(this).width <= ResponsiveWidget.of(this).sm;

  /// 平板设备，最大宽度默认1024
  bool get md => MediaQuery.sizeOf(this).width <= ResponsiveWidget.of(this).md;

  /// 桌面设备，最大宽度默认1920
  bool get lg => MediaQuery.sizeOf(this).width <= ResponsiveWidget.of(this).lg;

  /// 大屏桌面设备，最大宽度默认2560
  bool get xl => MediaQuery.sizeOf(this).width <= ResponsiveWidget.of(this).xl;
}

class ResponsiveWidget extends InheritedWidget {
  const ResponsiveWidget({
    super.key,
    required super.child,
    required this.data,
  });

  final ResponsiveData data;

  static ResponsiveData of(BuildContext context) {
    final ResponsiveWidget? result =
    context.dependOnInheritedWidgetOfExactType<ResponsiveWidget>();
    assert(result != null, 'No ResponsiveWidget found in context');
    return result!.data;
  }

  @override
  bool updateShouldNotify(ResponsiveWidget oldWidget) => true;
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
