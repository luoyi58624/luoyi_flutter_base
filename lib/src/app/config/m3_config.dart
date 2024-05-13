part of '../../../luoyi_flutter_base.dart';

/// Material3全局配置
class M3ConfigData {
  /// M3 默认配置
  static M3ConfigData config = M3ConfigData();

  /// M3 自定义配置
  static M3ConfigData customConfig = M3ConfigData(
    cardElevation: 0,
    appbar: M3AppbarConfigData(
      height: 50,
      scrollShade: false,
    ),
  );

  /// 卡片默认海拔
  double cardElevation;

  late M3AppbarConfigData appbar;

  M3ConfigData({
    this.cardElevation = 1,
    M3AppbarConfigData? appbar,
  }) {
    this.appbar = appbar ?? M3AppbarConfigData.config;
  }

  M3ConfigData copyWith({
    double? cardElevation,
    M3AppbarConfigData? appbar,
  }) {
    return M3ConfigData(
      cardElevation: cardElevation ?? this.cardElevation,
      appbar: appbar ?? this.appbar,
    );
  }
}

class M3AppbarConfigData {
  /// M3Appbar 配置实例
  static M3AppbarConfigData config = M3AppbarConfigData();

  /// Appbar高度
  double height;

  /// 滚动时 AppBar 背景颜色是否发生改变
  bool scrollShade;

  M3AppbarConfigData({
    this.height = 56,
    this.scrollShade = true,
  });

  M3AppbarConfigData copyWith({
    double? height,
    bool? scrollShade,
  }) {
    return M3AppbarConfigData(
      height: height ?? this.height,
      scrollShade: scrollShade ?? this.scrollShade,
    );
  }
}
