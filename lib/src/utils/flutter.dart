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
  static Future<void> hideKeybord() async {
    await SystemChannels.textInput.invokeMethod('TextInput.hide');
  }

  /// 显示手机软键盘
  static Future<void> showKeybord() async {
    await SystemChannels.textInput.invokeMethod('TextInput.show');
  }

  /// 隐藏手机软键盘并失去焦点
  static Future<void> unfocus() async {
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

  static FontWeight loadFontWeight(int index) {
    switch (index) {
      case 100:
        return FontWeight.w100;
      case 200:
        return FontWeight.w200;
      case 300:
        return FontWeight.w300;
      case 400:
        return FontWeight.w400;
      case 500:
        return FontWeight.w500;
      case 600:
        return FontWeight.w600;
      case 700:
        return FontWeight.w700;
      case 800:
        return FontWeight.w800;
      case 900:
        return FontWeight.w900;
      default:
        return FontWeight.w400;
    }
  }
}
