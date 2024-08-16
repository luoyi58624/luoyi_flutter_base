import 'package:flutter/widgets.dart';
import 'package:luoyi_flutter_base/luoyi_flutter_base.dart';

/// 全局导航 key
final GlobalKey<NavigatorState> globalNavigatorKey = GlobalKey();

/// 全局 context 对象
BuildContext get globalContext {
  assert(
      globalNavigatorKey.currentWidget != null &&
          globalNavigatorKey.currentWidget is Navigator,
      '请在 WidgetsApp、MaterialApp、CupertinoApp 等任意顶级 App 组件中设置 navigatorKey');
  return globalNavigatorKey.currentContext!;
}

TextStyle _defaultTextStyle = TextStyle(
  fontSize: PlatformUtil.isMobile ? 15 : 16,
);

TextStyle _globalTextStyle = const TextStyle().merge(_defaultTextStyle);

/// 全局文本样式
TextStyle get globalTextStyle => _globalTextStyle;

/// 设置全局文本样式
set globalTextStyle(TextStyle style) {
  _globalTextStyle = _defaultTextStyle.merge(style);
}
