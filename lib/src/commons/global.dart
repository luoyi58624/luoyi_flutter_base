import 'package:flutter/widgets.dart';

import '../utils/platform/platform.dart';

TextStyle _defaultTextStyle = TextStyle(
  // 全局字体大小，在 TextWidget 中，此属性可以被 DefaultTextStyle 覆盖，
  // 你可以使用 globalTextStyle 扩展函数应用全局文本样式
  fontSize: PlatformUtil.isMobile ? 15 : 16,
  // 字体族，在 TextWidget 中，此属性的优先级高于 DefaultTextStyle
  fontFamily: null,
  // 字体回退列表，在 TextWidget 中，此属性的优先级高于 DefaultTextStyle
  fontFamilyFallback: (PlatformUtil.isMacOS || PlatformUtil.isIOS)
      ? ['.AppleSystemUIFont', 'PingFang SC']
      : PlatformUtil.isWindows
          ? ['Microsoft YaHei', '微软雅黑']
          : null,
);

class GlobalConfig {
  GlobalConfig._();

  static TextStyle _textStyle = const TextStyle().merge(_defaultTextStyle);

  /// 全局文本样式
  static TextStyle get textStyle => _textStyle;

  /// 设置全局文本样式
  static set textStyle(TextStyle style) {
    _textStyle = _defaultTextStyle.merge(style);
  }

  /// 全局导航 key
  static final GlobalKey<NavigatorState> navigatorKey = GlobalKey();

  /// 全局 context 对象
  static BuildContext get context {
    assert(
        navigatorKey.currentWidget != null &&
            navigatorKey.currentWidget is Navigator,
        '请在 WidgetsApp、MaterialApp、CupertinoApp 等任意顶级 App 组件中设置 navigatorKey');
    return navigatorKey.currentContext!;
  }
}
