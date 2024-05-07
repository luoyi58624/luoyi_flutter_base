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
        } else {
          _setFontWeight(FontWeight.w400, FontWeight.w500, FontWeight.bold);
        }
      }
      // Windows平台默认不包含w500字重，中等字重调整为400
      else if (GetPlatform.isWindows) {
        _setFontWeight(FontWeight.w400, FontWeight.w400, FontWeight.bold);
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
      return ['Microsoft YaHei', '微软雅黑'];
    } else {
      return null;
    }
  }

  /// 根据底层默认样式重置字重，只是将[FontWeight.w400]、[FontWeight.w500]设置为[normal]、[medium]
  ///
  /// 提示：flutter底层会将用户的配置进行合并，你无需担心影响其他默认值
  static TextTheme get _textTheme {
    return TextTheme(
      displayLarge: TextStyle(fontWeight: normal),
      displayMedium: TextStyle(fontWeight: normal),
      displaySmall: TextStyle(fontWeight: normal),
      headlineLarge: TextStyle(fontWeight: normal),
      headlineMedium: TextStyle(fontWeight: normal),
      headlineSmall: TextStyle(fontWeight: normal),
      titleLarge: TextStyle(fontWeight: bold),
      titleMedium: TextStyle(fontWeight: bold),
      titleSmall: TextStyle(fontWeight: bold),
      bodyLarge: TextStyle(fontWeight: normal),
      bodyMedium: TextStyle(fontWeight: normal),
      bodySmall: TextStyle(fontWeight: normal),
      labelLarge: TextStyle(fontWeight: medium),
      labelMedium: TextStyle(fontWeight: medium),
      labelSmall: TextStyle(fontWeight: medium),
    );
  }
}
