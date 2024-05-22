part of '../../luoyi_flutter_base.dart';

/// 平台亮度小部件，抹平[MaterialApp]、[CupertinoApp]等不同主题系统的差异
///
/// 示例：
/// ```dart
/// // MaterialApp下判断是否是暗黑主题
/// Theme.of(context).brightness == Brightness.dark;
///
/// // CupertinoApp下判断是否是暗黑主题
/// CupertinoTheme.of(context).brightness == Brightness.dark;
///
/// // 统一判断当前是否是暗黑主题
/// BrightnessWidget.isDark(context);
/// ```
///
/// 使用：
/// ```dart
/// MaterialApp(
///   builder: (context, child) => BrightnessWidget(
///     brightness: Theme.of(context).brightness,
///     child: child!,
///   ),
/// );
///
/// CupertinoApp(
///   builder: (context, child) => BrightnessWidget(
///     brightness: CupertinoTheme.of(context).brightness,
///     child: child!,
///   ),
/// );
/// ```
class BrightnessWidget extends InheritedWidget {
  const BrightnessWidget({
    super.key,
    required super.child,
    this.brightness,
  });

  /// 当前平台的亮度模式, 如果没有指定, 则跟随系统: [MediaQueryData.platformBrightness]
  final Brightness? brightness;

  /// 判断当前是否是黑暗模式
  static bool isDark(BuildContext context) => of(context) == Brightness.dark;

  static Brightness of(BuildContext context) {
    final BrightnessWidget? result = context.dependOnInheritedWidgetOfExactType<BrightnessWidget>();
    assert(result != null, 'No BrightnessWidget found in context');
    return result!.brightness ?? MediaQuery.of(context).platformBrightness;
  }

  @override
  bool updateShouldNotify(BrightnessWidget oldWidget) {
    return true;
  }
}
