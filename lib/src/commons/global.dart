import 'package:flutter/widgets.dart';

import 'models.dart';

class GlobalConfig {
  GlobalConfig._();

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

  static ResponsiveData responsive = const ResponsiveData();
}
