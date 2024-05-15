part of '../../../luoyi_flutter_base.dart';

class AppConfigData {
  /// 默认的配置对象
  static AppConfigData config = AppConfigData();

  /// 全局字体
  String? fontFamily;

  /// 全局字体名字
  String get fontFamilyName => fontFamily == null || fontFamily == '' ? '系统字体' : fontFamily!;

  /// 如果[fontFamily]为空，那么会依次根据设置的字体列表去匹配相应的字体
  List<String>? fontFamilyFallback;

  /// 是否启用material3，默认true
  bool useMaterial3;

  /// 组件默认圆角值
  double radius;

  /// 导航栏标题是否居中，默认情况下，移动端标题将居中、桌面端则左对齐
  bool? centerTitle;

  /// 是否开启全局波纹，默认true
  bool enableRipple;

  /// 是否为紧凑布局
  bool dense;

  /// 鼠标悬停背景颜色变化级别：1-100
  int hoverScale;

  /// 手指点击、鼠标点击背景颜色变化级别：1-100
  int tapScale;

  /// text尺寸配置
  late TextSizeConfigData textSizeConfig;

  /// Material2 配置
  late M2ConfigData m2Config;

  /// Material3 配置
  late M3ConfigData m3Config;

  AppConfigData({
    String? fontFamily,
    List<String>? fontFamilyFallback,
    this.useMaterial3 = true,
    this.radius = 6,
    this.centerTitle,
    this.enableRipple = true,
    this.dense = false,
    this.hoverScale = 8,
    this.tapScale = 14,
    TextSizeConfigData? textSizeConfig,
    M2ConfigData? m2Config,
    M3ConfigData? m3Config,
  }) {
    this.fontFamily = fontFamily ?? FontUtil.fontFamily;
    this.fontFamilyFallback = fontFamilyFallback ?? _fontFamilyFallback;
    centerTitle = centerTitle ?? (GetPlatform.isMobile ? true : false);
    this.textSizeConfig = textSizeConfig ?? TextSizeConfigData.config;
    this.m2Config = m2Config ?? M2ConfigData.config;
    this.m3Config = m3Config ?? M3ConfigData.customConfig;
  }

  AppConfigData copyWith({
    String? fontFamily,
    List<String>? fontFamilyFallback,
    bool? useMaterial3,
    double? radius,
    bool? centerTitle,
    bool? enableRipple,
    bool? dense,
    int? hoverScale,
    int? tapScale,
    TextSizeConfigData? textSizeConfig,
    M2ConfigData? m2Config,
    M3ConfigData? m3Config,
  }) {
    return AppConfigData(
      fontFamily: fontFamily ?? this.fontFamily,
      fontFamilyFallback: fontFamilyFallback ?? this.fontFamilyFallback,
      useMaterial3: useMaterial3 ?? this.useMaterial3,
      radius: radius ?? this.radius,
      centerTitle: centerTitle ?? this.centerTitle,
      enableRipple: enableRipple ?? this.enableRipple,
      dense: dense ?? this.dense,
      hoverScale: hoverScale ?? this.hoverScale,
      tapScale: tapScale ?? this.tapScale,
      textSizeConfig: textSizeConfig ?? this.textSizeConfig,
      m2Config: m2Config ?? this.m2Config,
      m3Config: m3Config ?? this.m3Config,
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
