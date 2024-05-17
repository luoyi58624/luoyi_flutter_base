part of '../../luoyi_flutter_base.dart';

/// 顶级App组件，实现注入全局配置信息，构建[ThemeData]、[CupertinoThemeData]，构建[Overlay]遮罩层等功能
class AppWidget extends InheritedWidget {
  /// 注入[AppConfigData]全局配置数据
  AppWidget({
    super.key,
    required super.child,
    AppConfigData? data,
  }) {
    this.data = data ?? AppConfigData.config;
  }

  /// 全局配置数据
  late final AppConfigData data;

  /// 获取全局配置数据
  static AppConfigData of(BuildContext context) {
    final AppWidget? result = context.dependOnInheritedWidgetOfExactType<AppWidget>();
    assert(result != null, 'No App found in context');
    return result!.data;
  }

  /// 创建[Overlay]遮罩层，若没遮罩层，那么toast将无法使用
  /// ```dart
  /// MaterialApp(
  ///   builder: AppWidget.builder(),
  /// );
  ///
  /// // 插入你自己自定义的builder方法
  /// MaterialApp(
  ///   builder: AppWidget.builder(
  ///     (context, child) => SizeBox(child: child!),
  ///   ),
  /// );
  /// ```
  static Widget Function(BuildContext, Widget?) builder([TransitionBuilder? builder]) =>
      (BuildContext context, Widget? child) {
        Widget overlayWidget = Overlay(
          initialEntries: [
            OverlayEntry(builder: (context) {
              _toast.init(context);
              return child!;
            })
          ],
        );
        return builder == null ? overlayWidget : builder(context, overlayWidget);
      };

  /// 根据注入的[AppConfigData]，构建 Material 主题数据
  static ThemeData buildThemeData({
    AppConfigData? data,
    Brightness brightness = Brightness.light,
  }) {
    data ??= AppConfigData.config;
    return _buildThemeData(data, brightness);
  }

  /// 根据注入的[AppConfigData]，构建 Cupertino 主题数据
  static CupertinoThemeData buildCupertinoThemeData({
    AppConfigData? data,
    Brightness brightness = Brightness.light,
  }) {
    data ??= AppConfigData.config;
    return _buildCupertinoThemeData(data, brightness);
  }

  @override
  bool updateShouldNotify(AppWidget oldWidget) {
    return false;
  }
}
