part of '../../luoyi_flutter_base.dart';

extension AppResponsiveContextExtension on BuildContext {
  /// 移动端设备
  bool get sm => MediaQuery.sizeOf(this).width < AppResponsiveWidget.of(this).sm;

  /// 平板设备
  bool get md => MediaQuery.sizeOf(this).width < AppResponsiveWidget.of(this).md;

  /// 桌面设备
  bool get lg => MediaQuery.sizeOf(this).width < AppResponsiveWidget.of(this).lg;

  /// 大屏桌面设备
  bool get xl => MediaQuery.sizeOf(this).width < AppResponsiveWidget.of(this).xl;
}

/// 注入全局主题数据
class AppResponsiveWidget extends InheritedWidget {
  AppResponsiveWidget({
    super.key,
    required super.child,
    AppResponsiveData? data,
  }) {
    _data = data ?? AppResponsiveData.defaultData;
  }

  late final AppResponsiveData _data;

  /// 通过上下文获取响应式配置
  static AppResponsiveData of(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<AppResponsiveWidget>()?._data ?? AppResponsiveData.defaultData;

  @override
  bool updateShouldNotify(AppThemeWidget oldWidget) => true;
}

class AppResponsiveData {
  /// 默认的响应式配置
  static AppResponsiveData defaultData = AppResponsiveData();

  /// 手机最大尺寸
  final double sm;

  /// 平板最大尺寸
  final double md;

  /// 桌面最大尺寸
  final double lg;

  /// 大屏桌面最大尺寸
  final double xl;

  AppResponsiveData({
    this.sm = 640,
    this.md = 1024,
    this.lg = 1920,
    this.xl = 2560,
  });

  AppResponsiveData copyWith({
    double? sm,
    double? md,
    double? lg,
    double? xl,
  }) {
    return AppResponsiveData(
      sm: sm ?? this.sm,
      md: md ?? this.md,
      lg: lg ?? this.lg,
      xl: xl ?? this.xl,
    );
  }
}
