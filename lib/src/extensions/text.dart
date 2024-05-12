part of '../../luoyi_flutter_base.dart';

/// 通用的文字排版样式
extension FlutterTextExtension on BuildContext {
  TextStyle get h1 => TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: appConfig.textSizeConfigData.h1,
        color: appTheme.textColor,
      );

  TextStyle get h2 => TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: appConfig.textSizeConfigData.h2,
        color: appTheme.textColor,
      );

  TextStyle get h3 => TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: appConfig.textSizeConfigData.h3,
        color: appTheme.textColor,
      );

  TextStyle get h4 => TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: appConfig.textSizeConfigData.h4,
        color: appTheme.textColor,
      );

  TextStyle get h5 => TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: appConfig.textSizeConfigData.h5,
        color: appTheme.textColor,
      );

  TextStyle get h6 => TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: appConfig.textSizeConfigData.h6,
        color: appTheme.textColor,
      );
}
