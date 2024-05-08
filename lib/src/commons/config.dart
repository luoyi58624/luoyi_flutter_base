part of '../../luoyi_flutter_base.dart';

class FlutterConfigData {
  /// 默认的配置对象
  static FlutterConfigData config = FlutterConfigData();

  /// 自定义全局字体
  String? fontFamily;

  /// 头部高度 (appbar、navbar)
  double headerHeight;

  /// 是否启用material3，默认true
  bool useMaterial3;

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
  late M2ConfigData m2ConfigData;

  /// Material3 配置
  late M3ConfigData m3ConfigData;

  FlutterConfigData({
    this.fontFamily,
    this.headerHeight = 44,
    this.useMaterial3 = true,
    this.radius = 6,
    this.centerTitle,
    this.enableRipple = true,
    this.hoverScale = 8,
    this.tapScale = 14,
    M2ConfigData? m2ConfigData,
    M3ConfigData? m3ConfigData,
  }) {
    centerTitle = centerTitle ?? (GetPlatform.isMobile ? true : false);
    this.m2ConfigData = m2ConfigData ?? M2ConfigData.config;
    this.m3ConfigData = m3ConfigData ?? M3ConfigData.config;
  }

  FlutterConfigData copyWith({
    String? fontFamily,
    double? headerHeight,
    bool? useMaterial3,
    double? radius,
    bool? centerTitle,
    bool? enableRipple,
    int? hoverScale,
    int? tapScale,
  }) {
    return FlutterConfigData(
      fontFamily: fontFamily ?? this.fontFamily,
      headerHeight: headerHeight ?? this.headerHeight,
      useMaterial3: useMaterial3 ?? this.useMaterial3,
      radius: radius ?? this.radius,
      centerTitle: centerTitle ?? this.centerTitle,
      enableRipple: enableRipple ?? this.enableRipple,
      hoverScale: hoverScale ?? this.hoverScale,
      tapScale: tapScale ?? this.tapScale,
    );
  }
}

/// Material2全局配置
class M2ConfigData {
  /// 默认的配置实例
  static M2ConfigData config = M2ConfigData();

  /// AppBar海拔高度
  double appBarElevation;

  /// AppBar滚动时海拔高度
  double appBarScrollElevation;

  /// 是否启用半透明状态栏，默认false
  bool translucenceStatusBar;

  M2ConfigData({
    this.appBarElevation = 0,
    this.appBarScrollElevation = 2,
    this.translucenceStatusBar = false,
  });

  M2ConfigData copyWith({
    double? appBarElevation,
    double? appBarScrollElevation,
    bool? translucenceStatusBar,
  }) {
    return M2ConfigData(
      appBarElevation: appBarElevation ?? this.appBarElevation,
      appBarScrollElevation: appBarScrollElevation ?? this.appBarScrollElevation,
      translucenceStatusBar: translucenceStatusBar ?? this.translucenceStatusBar,
    );
  }
}

/// Material3全局配置
class M3ConfigData {
  /// 默认的配置实例
  static M3ConfigData config = M3ConfigData();

  /// 滚动时 AppBar 背景颜色改变，这里默认false，取消官方的默认行为
  bool appBarScrollShade;

  M3ConfigData({
    this.appBarScrollShade = false,
  });

  M3ConfigData copyWith({
    bool? appBarScrollShade,
  }) {
    return M3ConfigData(
      appBarScrollShade: appBarScrollShade ?? this.appBarScrollShade,
    );
  }
}
