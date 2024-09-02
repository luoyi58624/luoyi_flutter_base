import 'package:flutter/widgets.dart';

import '../utils/platform/platform.dart';
import '../utils/responsive.dart';

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

  /// 响应式配置
  static ResponsiveData responsive = const ResponsiveData();

  /// 切换全局主题动画持续时间，它被用于 [MaterialApp] themeAnimationDuration 属性，防止自定义组件的动画与 Material 不一致
  static Duration themeDuration = const Duration(milliseconds: 200);

  /// 全局文本尺寸，当注入 [ElConfigProvider] 时初始化，如果你没有指定字体尺寸，
  /// 默认情况下在移动端字体为 15 像素，桌面端为 16 像素。
  static double? _globalFontSize;

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
