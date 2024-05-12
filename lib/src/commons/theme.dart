part of '../../luoyi_flutter_base.dart';

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

  /// 背景色
  Color bgColor;

  /// 二级背景色，例如：卡片、底部导航栏
  Color bgColor2;

  /// 三级背景色
  Color bgColor3;

  /// 四级背景色
  Color bgColor4;

  /// 五级背景色
  Color bgColor5;

  /// 头部导航栏背景颜色
  Color headerColor;

  /// 文字颜色
  Color textColor;

  /// 二级文字颜色，颜色更浅
  Color textColor2;

  /// icon颜色
  Color iconColor;

  /// 二级icon颜色，颜色更浅
  Color iconColor2;

  /// 默认的亮色主题构造函数
  AppThemeData({
    this.primary = const Color.fromARGB(255, 0, 120, 212),
    this.success = const Color.fromARGB(255, 16, 185, 129),
    this.info = const Color.fromARGB(255, 127, 137, 154),
    this.warning = const Color.fromARGB(255, 245, 158, 11),
    this.error = const Color.fromARGB(255, 239, 68, 68),
    this.bgColor = const Color(0xffffffff),
    this.bgColor2 = const Color(0xfffafafa),
    this.bgColor3 = const Color(0xfff6f6f6),
    this.bgColor4 = const Color(0xfff1f3f5),
    this.bgColor5 = const Color(0xffe5e7eb),
    this.headerColor = const Color(0xfff3f4f6),
    this.textColor = const Color(0xff1f1f1f),
    this.textColor2 = const Color(0xff606368),
    this.iconColor = const Color(0xff1b1e23),
    this.iconColor2 = const Color(0xff606368),
  });

  /// 默认的暗色主题构造函数
  AppThemeData.dark({
    this.primary = const Color(0xff0ea5e9),
    this.success = const Color(0xff14b8a6),
    this.info = const Color(0xff64748B),
    this.warning = const Color(0xfffbbf24),
    this.error = const Color(0xfffb7185),
    this.bgColor = const Color(0xff181818),
    this.bgColor2 = const Color(0xff2d2d2d),
    this.bgColor3 = const Color(0xff4a4a4a),
    this.bgColor4 = const Color(0xff52525B),
    this.bgColor5 = const Color(0xff71717A),
    this.headerColor = const Color(0xff404040),
    this.textColor = const Color(0xfffafafa),
    this.textColor2 = const Color(0xffe5e5e5),
    this.iconColor = const Color(0xfff6f6f6),
    this.iconColor2 = const Color(0xffd4d4d4),
  });

  @override
  AppThemeData copyWith({
    Color? primary,
    Color? success,
    Color? info,
    Color? warning,
    Color? error,
    Color? bgColor,
    Color? bgColor2,
    Color? bgColor3,
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
      bgColor2: bgColor2 ?? this.bgColor2,
      bgColor3: bgColor3 ?? this.bgColor3,
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
