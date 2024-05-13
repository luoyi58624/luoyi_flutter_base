part of '../../luoyi_flutter_base.dart';

class AppData extends InheritedWidget {
  /// App全局数据
  AppData({
    super.key,
    required super.child,
    AppThemeData? theme,
    AppThemeData? darkTheme,
    AppConfigData? config,
  }) {
    this.theme = theme ?? AppThemeData.theme;
    this.darkTheme = darkTheme ?? AppThemeData.darkTheme;
    this.config = config ?? AppConfigData.config;
  }

  /// 亮色主题
  late final AppThemeData theme;

  /// 暗色主题
  late final AppThemeData darkTheme;

  /// 全局配置
  late final AppConfigData config;

  static AppData? maybeOf(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<AppData>();
  }

  static AppData of(BuildContext context) {
    final AppData? result = maybeOf(context);
    assert(result != null, 'No AppData found in context');
    return result!;
  }

  @override
  bool updateShouldNotify(AppData oldWidget) {
    return false;
  }
}
