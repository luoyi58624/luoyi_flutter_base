part of '../../luoyi_flutter_base.dart';

class FontUtil {
  FontUtil._();

  /// 基础字重字体，它对应[FontWeight.w400]
  ///
  /// 注意：如果你没有强制指定，该值会在部分设备上使用[FontWeight.w500]字重
  static late final FontWeight normal;

  /// 中等字重字体，它对应[FontWeight.w500]
  ///
  /// 注意：某些设备不存在w500字重，如果你没有强制指定，该值会在部分设备上使用[FontWeight.w400]字重
  static late final FontWeight medium;

  /// 粗体字重字体，它对应[FontWeight.bold]
  static late final FontWeight bold;

  /// 初始化字体，根据不同平台设备应用最佳字体。
  ///
  /// 如果你使用自定义字体，则可以传递相应参数强制指定字重，如下:
  /// * normal 指定普通字重
  /// * medium 指定中等字重
  /// * bold 指定粗体字重
  static void init({
    FontWeight? normal,
    FontWeight? medium,
    FontWeight? bold,
  }) {
    if (!_isInit) {
      _isInit = true;
      _init(normal: normal, medium: medium, bold: bold);
    }
  }

  static bool _isInit = false;

  static void _init({
    FontWeight? normal,
    FontWeight? medium,
    FontWeight? bold,
  }) {
    _normal = normal;
    _medium = medium;
    _bold = bold;
    if (GetPlatform.isWeb) {
      _setFontWeight(FontWeight.w400, FontWeight.w500, FontWeight.bold);
    } else {
      if (GetPlatform.isAndroid) {
        // 小米w400字重偏细，为了提升观感，将基础字重设置为500
        if (DeviceUtil.isXiaomi) {
          _setFontWeight(FontWeight.w500, FontWeight.w500, FontWeight.bold);
        } else if (DeviceUtil.isHUAWEI) {
          _setFontWeight(FontWeight.w400, FontWeight.w500, FontWeight.w600);
        } else {
          _setFontWeight(FontWeight.w400, FontWeight.w500, FontWeight.bold);
        }
      }
      // Windows平台默认不包含w500字重，中等字重调整为400
      else if (GetPlatform.isWindows) {
        _setFontWeight(FontWeight.w500, FontWeight.w500, FontWeight.w600);
      } else {
        _setFontWeight(FontWeight.w400, FontWeight.w500, FontWeight.bold);
      }
    }
  }

  static FontWeight? _normal;
  static FontWeight? _medium;
  static FontWeight? _bold;

  static void _setFontWeight(FontWeight normalFont, FontWeight mediumFont, FontWeight boldFont) {
    normal = _normal ?? normalFont;
    medium = _medium ?? mediumFont;
    bold = _bold ?? boldFont;
  }

  /// 优先加载的字体族列表
  static List<String>? get _fontFamilyFallback {
    if (GetPlatform.isMacOS || GetPlatform.isIOS) {
      return ['.AppleSystemUIFont', 'PingFang SC'];
    } else if (GetPlatform.isWindows) {
      return ['Microsoft YaHei', '微软雅黑', 'NotoSansSC'];
    } else {
      return null;
    }
  }

  /// material文字排版主题，关于M3的字体排版规范请查看：https://m3.material.io/styles/typography/applying-type
  ///
  /// 参数解析：
  /// * display 屏幕上最大的文本，用于海报
  /// * headline 大字标题，用于显示简短、突出的问题，例如：Dialog标题
  ///
  /// 提示：flutter底层会将用户的配置进行合并，你无需担心影响其他默认值
  static TextTheme _textTheme(FlutterThemeData theme) {
    return TextTheme(
      displayLarge: TextStyle(fontWeight: normal, color: theme.textColor),
      displayMedium: TextStyle(fontWeight: normal, color: theme.textColor),
      displaySmall: TextStyle(fontWeight: normal, color: theme.textColor),
      headlineLarge: TextStyle(fontWeight: medium, color: theme.textColor),
      headlineMedium: TextStyle(fontWeight: medium, color: theme.textColor),
      headlineSmall: TextStyle(fontWeight: medium, color: theme.textColor),
      titleLarge: TextStyle(fontWeight: bold, color: theme.textColor),
      titleMedium: TextStyle(fontWeight: bold, color: theme.textColor),
      titleSmall: TextStyle(fontWeight: bold, color: theme.textColor),
      bodyLarge: TextStyle(fontWeight: normal, color: theme.textColor),
      bodyMedium: TextStyle(fontWeight: normal, color: theme.textColor),
      bodySmall: TextStyle(fontWeight: normal, color: theme.textColor),
      labelLarge: TextStyle(fontWeight: medium, color: theme.textColor),
      labelMedium: TextStyle(fontWeight: medium, color: theme.textColor),
      labelSmall: TextStyle(fontWeight: medium, color: theme.textColor),
    );
  }

  /// material2字体主题
  static TextTheme _m2TextTheme(FlutterThemeData theme) {
    return TextTheme(
      displayLarge: TextStyle(fontWeight: normal, color: theme.textColor),
      displayMedium: TextStyle(fontWeight: normal, color: theme.textColor),
      displaySmall: TextStyle(fontWeight: normal, color: theme.textColor),
      headlineLarge: TextStyle(fontWeight: normal, color: theme.textColor),
      headlineMedium: TextStyle(fontWeight: normal, color: theme.textColor),
      headlineSmall: TextStyle(fontWeight: normal, color: theme.textColor),
      titleLarge: TextStyle(fontWeight: medium, color: theme.textColor),
      titleMedium: TextStyle(fontWeight: medium, color: theme.textColor),
      titleSmall: TextStyle(fontWeight: medium, color: theme.textColor),
      bodyLarge: TextStyle(fontWeight: normal, color: theme.textColor),
      bodyMedium: TextStyle(fontWeight: normal, color: theme.textColor),
      bodySmall: TextStyle(fontWeight: normal, color: theme.textColor),
      labelLarge: TextStyle(fontWeight: medium, color: theme.textColor),
      labelMedium: TextStyle(fontWeight: medium, color: theme.textColor),
      labelSmall: TextStyle(fontWeight: medium, color: theme.textColor),
    );
  }


}


