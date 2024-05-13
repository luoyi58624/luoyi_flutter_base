part of '../../../luoyi_flutter_base.dart';

/// Material2全局配置
class M2ConfigData {
  /// M2 默认配置
  static M2ConfigData config = M2ConfigData();

  /// M2 自定义配置
  static M2ConfigData customConfig = M2ConfigData(
    cardElevation: 1,
    translucenceStatusBar: false,
    appbar: M2AppbarConfigData(
      usePrimaryColor: false,
      height: 50,
      elevation: 0,
      scrollElevation: 2,
    ),
  );

  /// 卡片默认海拔
  double cardElevation;

  /// 是否启用半透明状态栏，默认false
  bool translucenceStatusBar;

  /// M2 Appbar配置
  late M2AppbarConfigData appbar;

  M2ConfigData({
    this.cardElevation = 2,
    this.translucenceStatusBar = true,
    M2AppbarConfigData? appbar,
  }) {
    this.appbar = appbar ?? M2AppbarConfigData.config;
  }

  M2ConfigData copyWith({
    double? cardElevation,
    bool? translucenceStatusBar,
    M2AppbarConfigData? appbar,
  }) {
    return M2ConfigData(
      cardElevation: cardElevation ?? this.cardElevation,
      translucenceStatusBar: translucenceStatusBar ?? this.translucenceStatusBar,
      appbar: appbar ?? this.appbar,
    );
  }
}

class M2AppbarConfigData {
  /// 默认的 M2Appbar 配置实例
  static M2AppbarConfigData config = M2AppbarConfigData();

  /// M2 Appbar的背景色是否和 Primary 同步，如果为false，Appbar的背景色则为 headerColor
  bool usePrimaryColor;

  /// M2 Appbar高度
  double height;

  /// AppBar海拔高度
  double elevation;

  /// AppBar滚动时海拔高度
  double scrollElevation;

  M2AppbarConfigData({
    this.usePrimaryColor = true,
    this.height = 56,
    this.elevation = 4,
    this.scrollElevation = 4,
  });

  M2AppbarConfigData copyWith({
    bool? usePrimaryColor,
    double? height,
    double? elevation,
    double? scrollElevation,
  }) {
    return M2AppbarConfigData(
      usePrimaryColor: usePrimaryColor ?? this.usePrimaryColor,
      height: height ?? this.height,
      elevation: elevation ?? this.elevation,
      scrollElevation: scrollElevation ?? this.scrollElevation,
    );
  }
}
