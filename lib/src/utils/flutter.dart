part of '../../luoyi_flutter_base.dart';

class FlutterUtil {
  FlutterUtil._();

  /// 刷新整个应用
  static void refreshApp() {
    WidgetsBinding.instance.reassembleApplication();
  }

  /// 当flutter渲染完毕元素后再执行异步逻辑
  static void nextTick(Future<void> Function() fun) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      await fun();
    });
  }

  /// 隐藏手机软键盘但保留焦点
  static Future<void> hideKeyboard() async {
    await SystemChannels.textInput.invokeMethod('TextInput.hide');
  }

  /// 显示手机软键盘
  static Future<void> showKeyboard() async {
    await SystemChannels.textInput.invokeMethod('TextInput.show');
  }

  /// 隐藏手机软键盘并失去焦点
  static Future<void> unFocus() async {
    FocusManager.instance.primaryFocus?.unfocus();
  }

  /// 通过当前context，获取目标祖先元素
  static Element? getAncestorElement<T>(BuildContext context) {
    Element? element;
    context.visitAncestorElements((e) {
      if (e.widget is T) {
        element = e;
        return false;
      }
      return true;
    });
    return element;
  }

  /// 通过当前context，检查是否包含某个祖先widget
  static bool hasAncestorElement<T>(BuildContext context) {
    return getAncestorElement<T>(context) != null;
  }

  /// 是否是苹果平台：macos、ios
  static bool get isApple => GetPlatform.isMacOS || GetPlatform.isIOS;

  /// 是否是移动客户端平台
  static bool get isMobileClient => !kIsWeb && GetPlatform.isMobile;

  /// 是否是桌面客户端平台
  static bool get isDesktopClient => !kIsWeb && GetPlatform.isDesktop;
}
