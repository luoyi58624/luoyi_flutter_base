part of '../../luoyi_flutter_base.dart';

class AppConfigData {
  /// 默认的配置对象
  static AppConfigData config = AppConfigData();

  /// 自定义全局字体
  String? fontFamily;

  /// 如果[fontFamily]为空，那么会依次根据设置的字体列表去匹配相应的字体
  List<String>? fontFamilyFallback;

  /// 是否启用material3，默认true
  bool? useMaterial3;

  /// 组件默认圆角值
  double radius;

  /// 导航栏标题是否居中，默认情况下，移动端标题将居中、桌面端则左对齐
  bool? centerTitle;

  /// 是否开启全局波纹，默认true
  bool enableRipple;

  /// 鼠标悬停背景颜色变化级别：1-100
  int hoverScale;

  /// 手指点击、鼠标点击背景颜色变化级别：1-100
  int tapScale;

  /// Material2 配置
  late TextSizeConfigData textSizeConfigData;

  /// Material2 配置
  late M2ConfigData m2ConfigData;

  /// Material3 配置
  late M3ConfigData m3ConfigData;

  AppConfigData({
    this.fontFamily,
    this.fontFamilyFallback,
    this.useMaterial3,
    this.radius = 6,
    this.centerTitle,
    this.enableRipple = true,
    this.hoverScale = 8,
    this.tapScale = 14,
    TextSizeConfigData? textSizeConfigData,
    M2ConfigData? m2ConfigData,
    M3ConfigData? m3ConfigData,
  }) {
    centerTitle = centerTitle ?? (GetPlatform.isMobile ? true : false);
    this.textSizeConfigData = textSizeConfigData ?? TextSizeConfigData.config;
    this.m2ConfigData = m2ConfigData ?? M2ConfigData.config;
    this.m3ConfigData = m3ConfigData ?? M3ConfigData.config;
  }

  AppConfigData copyWith({
    String? fontFamily,
    List<String>? fontFamilyFallback,
    bool? useMaterial3,
    double? radius,
    bool? centerTitle,
    bool? enableRipple,
    int? hoverScale,
    int? tapScale,
  }) {
    return AppConfigData(
      fontFamily: fontFamily ?? this.fontFamily,
      fontFamilyFallback: fontFamilyFallback ?? this.fontFamilyFallback,
      useMaterial3: useMaterial3 ?? this.useMaterial3,
      radius: radius ?? this.radius,
      centerTitle: centerTitle ?? this.centerTitle,
      enableRipple: enableRipple ?? this.enableRipple,
      hoverScale: hoverScale ?? this.hoverScale,
      tapScale: tapScale ?? this.tapScale,
    );
  }
}

/// 文字大小配置
class TextSizeConfigData {
  /// 默认的配置实例
  static TextSizeConfigData config = TextSizeConfigData();

  double h1;
  double h2;
  double h3;
  double h4;
  double h5;
  double h6;

  TextSizeConfigData({
    this.h1 = 28,
    this.h2 = 24,
    this.h3 = 20,
    this.h4 = 18,
    this.h5 = 16,
    this.h6 = 14,
  });

  TextSizeConfigData copyWith({
    double? h1,
    double? h2,
    double? h3,
    double? h4,
    double? h5,
    double? h6,
  }) {
    return TextSizeConfigData(
      h1: h1 ?? this.h1,
      h2: h2 ?? this.h2,
      h3: h3 ?? this.h3,
      h4: h4 ?? this.h4,
      h5: h5 ?? this.h5,
      h6: h6 ?? this.h6,
    );
  }
}

/// Material2全局配置
class M2ConfigData {
  /// 默认的配置实例
  static M2ConfigData config = M2ConfigData();

  /// M2 Appbar高度
  double appbarHeight;

  /// AppBar海拔高度
  double appbarElevation;

  /// AppBar滚动时海拔高度
  double appbarScrollElevation;

  /// 是否启用半透明状态栏，默认false
  bool translucenceStatusBar;

  M2ConfigData({
    this.appbarHeight = 50,
    this.appbarElevation = 0,
    this.appbarScrollElevation = 2,
    this.translucenceStatusBar = true,
  });

  M2ConfigData copyWith({
    double? appbarHeight,
    double? appbarElevation,
    double? appbarScrollElevation,
    bool? translucenceStatusBar,
  }) {
    return M2ConfigData(
      appbarHeight: appbarHeight ?? this.appbarHeight,
      appbarElevation: appbarElevation ?? this.appbarElevation,
      appbarScrollElevation: appbarScrollElevation ?? this.appbarScrollElevation,
      translucenceStatusBar: translucenceStatusBar ?? this.translucenceStatusBar,
    );
  }
}

/// Material3全局配置
class M3ConfigData {
  /// 默认的配置实例
  static M3ConfigData config = M3ConfigData();

  /// M3 Appbar高度
  double appbarHeight;

  /// 滚动时 AppBar 背景颜色改变，这里默认false，取消官方的默认行为
  bool appBarScrollShade;

  M3ConfigData({
    this.appbarHeight = 50,
    this.appBarScrollShade = false,
  });

  M3ConfigData copyWith({
    double? appbarHeight,
    bool? appBarScrollShade,
  }) {
    return M3ConfigData(
      appbarHeight: appbarHeight ?? this.appbarHeight,
      appBarScrollShade: appBarScrollShade ?? this.appBarScrollShade,
    );
  }
}
