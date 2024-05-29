part of '../../luoyi_flutter_base.dart';

extension AppThemeContextExtension on BuildContext {
  /// 当前主题数据
  AppThemeData get appTheme =>
      BrightnessWidget.isDark(this) ? AppThemeWidget.darkTheme(this) : AppThemeWidget.theme(this);
}

/// 注入全局主题数据
class AppThemeWidget extends InheritedWidget {
  AppThemeWidget({
    super.key,
    required super.child,
    AppThemeData? theme,
    AppThemeData? darkTheme,
  }) {
    _theme = theme ?? AppThemeData.theme;
    _darkTheme = darkTheme ?? AppThemeData.darkTheme;
  }

  late final AppThemeData _theme;
  late final AppThemeData _darkTheme;

  static AppThemeWidget? _maybeOf(BuildContext context) => context.dependOnInheritedWidgetOfExactType<AppThemeWidget>();

  /// 通过上下文获取亮色主题
  static AppThemeData theme(BuildContext context) => _maybeOf(context)?._theme ?? AppThemeData.theme;

  /// 通过上下文获取暗色主题
  static AppThemeData darkTheme(BuildContext context) => _maybeOf(context)?._darkTheme ?? AppThemeData.darkTheme;

  @override
  bool updateShouldNotify(AppThemeWidget oldWidget) => true;
}

/// 主题数据
class AppThemeData {
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

  /// 主要背景色、全局背景色
  Color mainColor;

  /// 头部背景颜色，亮色模式下默认使用[primary]
  late Color headerColor;

  /// 卡片背景色，默认使用[mainColor]更深的颜色
  late Color cardColor;

  /// 模态弹窗背景色，亮色模式下默认使用[mainColor]
  late Color modalColor;

  /// 文字颜色
  Color textColor;

  /// icon颜色
  Color iconColor;

  /// 边框颜色
  Color borderColor;

  /// 卡片海拔高度，设置较低的海拔能让应用更加扁平化，设置较高的海拔则让应用更具层级感
  double cardElevation;

  /// 模态弹窗海拔高度
  double modalElevation;

  /// 根据字体颜色自动创建一组次级颜色: 0 - 5
  List<Color> get textColors =>
      List.generate(6, (index) => textColor.deepen(4 * (index + 1), darkScale: 8 * (index + 1)));

  /// 根据图标颜色自动创建一组次级颜色: 0 - 5
  List<Color> get iconColors =>
      List.generate(6, (index) => iconColor.deepen(4 * (index + 1), darkScale: 8 * (index + 1)));

  /// 默认的亮色主题构造函数
  AppThemeData({
    this.primary = const Color.fromARGB(255, 0, 120, 212),
    this.success = const Color.fromARGB(255, 16, 185, 129),
    this.info = const Color.fromARGB(255, 127, 137, 154),
    this.warning = const Color.fromARGB(255, 245, 158, 11),
    this.error = const Color.fromARGB(255, 239, 68, 68),
    this.mainColor = const Color(0xfffafafa),
    Color? headerColor,
    this.cardColor = const Color(0xffffffff),
    Color? modalColor,
    this.textColor = const Color(0xff1f1f1f),
    this.iconColor = const Color(0xff1b1e23),
    this.borderColor = const Color(0xffdcdfe6),
    this.cardElevation = 0,
    this.modalElevation = 2,
  }) {
    this.headerColor = headerColor ?? primary;
    this.modalColor = modalColor ?? mainColor;
  }

  /// 默认的暗色主题构造函数
  AppThemeData.dark({
    this.primary = const Color(0xff0ea5e9),
    this.success = const Color(0xff14b8a6),
    this.info = const Color(0xff64748B),
    this.warning = const Color(0xfffbbf24),
    this.error = const Color(0xfffb7185),
    this.mainColor = const Color(0xff2b2b2b),
    Color? headerColor = const Color(0xff3F3F46),
    this.cardColor = const Color(0xff3c3c3c),
    Color? modalColor = const Color(0xff3c3f41),
    this.textColor = const Color(0xfffafafa),
    this.iconColor = const Color(0xfff6f6f6),
    this.borderColor = const Color(0xffdcdfe6),
    this.cardElevation = 2,
    this.modalElevation = 4,
  }) {
    this.headerColor = headerColor ?? primary;
    this.modalColor = modalColor ?? mainColor;
  }

  AppThemeData copyWith({
    Color? primary,
    Color? success,
    Color? info,
    Color? warning,
    Color? error,
    Color? mainColor,
    Color? headerColor,
    Color? cardColor,
    Color? modalColor,
    Color? textColor,
    Color? iconColor,
    Color? borderColor,
    double? cardElevation,
    double? modalElevation,
  }) {
    return AppThemeData(
      primary: primary ?? this.primary,
      success: success ?? this.success,
      info: info ?? this.info,
      warning: warning ?? this.warning,
      error: error ?? this.error,
      mainColor: mainColor ?? this.mainColor,
      headerColor: headerColor ?? this.headerColor,
      cardColor: cardColor ?? this.cardColor,
      modalColor: modalColor ?? this.modalColor,
      textColor: textColor ?? this.textColor,
      iconColor: iconColor ?? this.iconColor,
      borderColor: borderColor ?? this.borderColor,
      cardElevation: cardElevation ?? this.cardElevation,
      modalElevation: modalElevation ?? this.modalElevation,
    );
  }
}
