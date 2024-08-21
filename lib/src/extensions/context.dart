import 'package:flutter/widgets.dart';

import '../commons/global.dart';

extension FlutterResponsiveExtension on BuildContext {
  /// 应用可视宽度
  double get clientWidth => MediaQuery.sizeOf(this).width;

  /// 极小设备，最大宽度默认320
  bool get xs => clientWidth <= GlobalConfig.responsive.xs;

  /// 移动端设备，最大宽度默认640
  bool get sm => clientWidth <= GlobalConfig.responsive.sm;

  /// 平板设备，最大宽度默认1024
  bool get md => clientWidth <= GlobalConfig.responsive.md;

  /// 桌面设备，最大宽度默认1920
  bool get lg => clientWidth <= GlobalConfig.responsive.lg;

  /// 大屏桌面设备，最大宽度默认2560
  bool get xl => clientWidth <= GlobalConfig.responsive.xl;
}
