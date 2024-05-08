part of '../../luoyi_flutter_base.dart';

/// 通用的文字排版样式
extension FlutterTextExtension on BuildContext {
  TextStyle get h1 => TextStyle(
        fontWeight: FontUtil.bold,
        fontSize: configData.textSizeConfigData.h1,
        color: currentThemeData.textColor,
      );

  TextStyle get h2 => TextStyle(
        fontWeight: FontUtil.bold,
        fontSize: configData.textSizeConfigData.h2,
        color: currentThemeData.textColor,
      );

  TextStyle get h3 => TextStyle(
        fontWeight: FontUtil.bold,
        fontSize: configData.textSizeConfigData.h3,
        color: currentThemeData.textColor,
      );

  TextStyle get h4 => TextStyle(
        fontWeight: FontUtil.bold,
        fontSize: configData.textSizeConfigData.h4,
        color: currentThemeData.textColor,
      );

  TextStyle get h5 => TextStyle(
        fontWeight: FontUtil.bold,
        fontSize: configData.textSizeConfigData.h5,
        color: currentThemeData.textColor,
      );

  TextStyle get h6 => TextStyle(
        fontWeight: FontUtil.bold,
        fontSize: configData.textSizeConfigData.h6,
        color: currentThemeData.textColor,
      );
}
