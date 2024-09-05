import 'package:flutter/widgets.dart';

import '../utils/platform/platform.dart';

class GlobalConfig {
  GlobalConfig._();

  static double? _globalFontSize;

  /// 全局文本尺寸，当注入 [ElConfigProvider] 时初始化，如果你没有指定字体尺寸，
  /// 默认情况下在移动端字体为 15 像素，桌面端为 16 像素。
  static double get globalFontSize {
    assert(_globalFontSize != null,
        '_globalFontSize 未初始化，请注入 ElConfigProvider 小部件');
    return _globalFontSize!;
  }

  static set globalFontSize(double v) {
    _globalFontSize = v;
  }

  /// 默认的文本样式
  static TextStyle defaultTextStyle = TextStyle(
    fontFamily: null,
    fontFamilyFallback: (PlatformUtil.isMacOS || PlatformUtil.isIOS)
        ? ['.AppleSystemUIFont', 'PingFang SC']
        : PlatformUtil.isWindows
            ? ['Microsoft YaHei', '微软雅黑']
            : null,
  );
}
