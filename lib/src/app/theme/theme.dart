part of '../../../luoyi_flutter_base.dart';

/// 自定义主题数据, 它是基于[MaterialApp]进行拓展的, 不管你创建什么类型的App，都建议将[MaterialApp]作为根App，
/// flutter存在很多其他根App: [CupertinoApp]、[FluentApp]、[MacosApp]，但实际上，
/// 你使用这些设计系统的组件并非必须使用特定的根App来创建应用, 只需通过[builder]属性注入各自的主题系统即可
/// ```dart
/// // 将主题注入到 ThemeData
/// MaterialApp(
///   theme: ThemeData(brightness: Brightness.light).copyWith(extensions: [
///     const AppThemeData(),
///   ]),
///   darkTheme: ThemeData(brightness: Brightness.dark).copyWith(extensions: [
///     const AppThemeData.dark(),
///   ]),
///   home: const HomePage(),
/// );
///
/// // 使用
/// Container(color: context.flutterTheme),
/// ```
class AppThemeData extends ThemeExtension<AppThemeData> {
  /// 默认亮色主题对象
  static AppThemeData theme = AppThemeData();

  /// 默认暗色主题对象
  static AppThemeData darkTheme = AppThemeData.dark();

  /// 主要颜色
  Color primary;

  /// 成功颜色
  Color success;

  /// 普通颜色
  Color info;

  /// 警告颜色
  Color warning;

  /// 错误颜色
  Color error;

  /// 全局背景色
  Color bgColor;

  /// 头部导航栏背景颜色
  Color headerColor;

  /// 文字颜色
  Color textColor;

  /// icon颜色
  Color iconColor;

  /// 根据背景色自动创建一组次级颜色，例如：
  /// 1. 卡片、底部导航栏
  /// 2. Pop弹窗
  List<Color> get bgColors => List.generate(4, (index) => bgColor.deepen(2 * (index + 1), darkScale: 10 * (index + 1)));

  /// 根据头部颜色自动创建一组次级颜色
  List<Color> get headerColors =>
      List.generate(4, (index) => headerColor.deepen(2 * (index + 1), darkScale: 10 * (index + 1)));

  /// 根据字体颜色自动创建一组次级颜色
  List<Color> get textColors =>
      List.generate(4, (index) => textColor.deepen(5 * (index + 1), darkScale: 8 * (index + 1)));

  /// 根据字体颜色自动创建一组次级颜色
  List<Color> get iconColors =>
      List.generate(4, (index) => iconColor.deepen(5 * (index + 1), darkScale: 8 * (index + 1)));

  /// 默认的亮色主题构造函数
  AppThemeData({
    this.primary = const Color.fromARGB(255, 0, 120, 212),
    this.success = const Color.fromARGB(255, 16, 185, 129),
    this.info = const Color.fromARGB(255, 127, 137, 154),
    this.warning = const Color.fromARGB(255, 245, 158, 11),
    this.error = const Color.fromARGB(255, 239, 68, 68),
    this.bgColor = const Color(0xffffffff),
    this.headerColor = const Color(0xfff3f4f6),
    this.textColor = const Color(0xff1f1f1f),
    this.iconColor = const Color(0xff1b1e23),
  });

  /// 默认的暗色主题构造函数
  AppThemeData.dark({
    this.primary = const Color(0xff0ea5e9),
    this.success = const Color(0xff14b8a6),
    this.info = const Color(0xff64748B),
    this.warning = const Color(0xfffbbf24),
    this.error = const Color(0xfffb7185),
    this.bgColor = const Color(0xff181818),
    this.headerColor = const Color(0xff404040),
    this.textColor = const Color(0xfffafafa),
    this.iconColor = const Color(0xfff6f6f6),
  });

  @override
  AppThemeData copyWith({
    Color? primary,
    Color? success,
    Color? info,
    Color? warning,
    Color? error,
    Color? bgColor,
    Color? headerColor,
    Color? textColor,
    Color? iconColor,
  }) {
    return AppThemeData(
      primary: primary ?? this.primary,
      success: success ?? this.success,
      info: info ?? this.info,
      warning: warning ?? this.warning,
      error: error ?? this.error,
      bgColor: bgColor ?? this.bgColor,
      headerColor: headerColor ?? this.headerColor,
      textColor: textColor ?? this.textColor,
      iconColor: iconColor ?? this.iconColor,
    );
  }

  @override
  ThemeExtension<AppThemeData> lerp(covariant ThemeExtension<AppThemeData>? other, double t) {
    return this;
  }
}
