part of '../../luoyi_flutter_base.dart';

class AppConfigData {
  static AppConfigData config = m3FlatConfig;

  /// Material2 配置
  static AppConfigData m2Config = AppConfigData(
    theme: AppThemeData(primary: Colors.blue),
    darkTheme: AppThemeData.dark(primary: Colors.blue),
    useMaterial3: false,
    appbarHeight: 56,
    appbarElevation: 4,
    appbarScrollElevation: 4,
    cardElevation: 2,
    translucenceStatusBar: true,
    radius: 4,
  );

  /// Material2 扁平化配置
  static AppConfigData m2FlatConfig = AppConfigData(
    theme: AppThemeData(primary: Colors.blue, headerColor: Colors.white),
    darkTheme: AppThemeData.dark(primary: Colors.blue),
    useMaterial3: false,
    appbarHeight: 56,
    appbarScrollElevation: 1,
    cardElevation: 1,
    radius: 4,
  );

  /// Material3 配置
  static AppConfigData m3Config = AppConfigData(
    theme: AppThemeData(headerColor: Colors.white),
    darkTheme: AppThemeData.darkTheme,
    useMaterial3: true,
    appbarHeight: 44,
    cardElevation: 1,
    radius: 6,
  );

  /// Material3 扁平化配置
  static AppConfigData m3FlatConfig = AppConfigData(
    theme: AppThemeData(headerColor: Colors.white),
    darkTheme: AppThemeData.darkTheme,
    useMaterial3: true,
    appbarHeight: 44,
    cardElevation: 0,
    radius: 6,
  );

  /// app亮色主题
  AppThemeData theme;

  /// app暗色主题
  AppThemeData darkTheme;

  /// 全局字体
  String? fontFamily;

  /// 全局字体名字
  String get fontFamilyName => fontFamily == null || fontFamily == '' ? '系统字体' : fontFamily!;

  /// 如果[fontFamily]为空，那么会依次根据设置的字体列表去匹配相应的字体
  List<String>? fontFamilyFallback;

  /// 是否启用material3，默认true
  bool useMaterial3;

  /// appbar高度
  double appbarHeight;

  /// appbar海拔高度
  double appbarElevation;

  /// app滚动时海拔高度
  double appbarScrollElevation;

  /// appbar标题是否居中，默认情况下，在移动端标题居中，pc端跟随默认
  late bool centerTitle;

  /// 卡片海拔高度
  double cardElevation;

  /// 是否开启半透明状态栏，注意：仅M2有效
  bool translucenceStatusBar;

  /// 组件默认圆角值
  double radius;

  /// 是否开启全局波纹，默认true
  bool enableRipple;

  /// 鼠标悬停背景颜色变化级别：1-100
  int hoverScale;

  /// 手指点击、鼠标点击背景颜色变化级别：1-100
  int tapScale;

  AppConfigData({
    required this.theme,
    required this.darkTheme,
    String? fontFamily,
    List<String>? fontFamilyFallback,
    this.useMaterial3 = true,
    this.appbarHeight = 50,
    this.appbarElevation = 0,
    this.appbarScrollElevation = 0,
    bool? centerTitle,
    this.cardElevation = 0,
    this.translucenceStatusBar = false,
    this.radius = 6,
    this.enableRipple = true,
    this.hoverScale = 8,
    this.tapScale = 14,
  }) {
    this.fontFamily = fontFamily ?? FontUtil.fontFamily;
    this.centerTitle = centerTitle ?? GetPlatform.isMobile ? true : false;
    this.fontFamilyFallback = fontFamilyFallback ?? _fontFamilyFallback;
  }

  AppConfigData copyWith({
    AppThemeData? theme,
    AppThemeData? darkTheme,
    String? fontFamily,
    List<String>? fontFamilyFallback,
    bool? useMaterial3,
    double? appbarHeight,
    double? appbarElevation,
    double? appbarScrollElevation,
    bool? centerTitle,
    double? cardElevation,
    bool? translucenceStatusBar,
    double? radius,
    bool? enableRipple,
    int? hoverScale,
    int? tapScale,
  }) {
    return AppConfigData(
      theme: theme ?? this.theme,
      darkTheme: darkTheme ?? this.darkTheme,
      fontFamily: fontFamily ?? this.fontFamily,
      fontFamilyFallback: fontFamilyFallback ?? this.fontFamilyFallback,
      useMaterial3: useMaterial3 ?? this.useMaterial3,
      appbarHeight: appbarHeight ?? this.appbarHeight,
      appbarElevation: appbarElevation ?? this.appbarElevation,
      appbarScrollElevation: appbarScrollElevation ?? this.appbarScrollElevation,
      centerTitle: centerTitle ?? this.centerTitle,
      cardElevation: cardElevation ?? this.cardElevation,
      translucenceStatusBar: translucenceStatusBar ?? this.translucenceStatusBar,
      radius: radius ?? this.radius,
      enableRipple: enableRipple ?? this.enableRipple,
      hoverScale: hoverScale ?? this.hoverScale,
      tapScale: tapScale ?? this.tapScale,
    );
  }
}
