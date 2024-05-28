part of '../../luoyi_flutter_base.dart';

extension AppConfigContextExtension on BuildContext {
  /// 全局配置数据
  AppConfigData get appConfig => AppConfigWidget.of(this);
}

/// 注入全局配置数据
class AppConfigWidget extends InheritedWidget {
  AppConfigWidget({
    super.key,
    required super.child,
    AppConfigData? data,
  }) {
    _data = data ?? AppConfigData.defaultData;
  }

  late final AppConfigData _data;

  /// 通过上下文获取全局配置
  static AppConfigData of(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<AppConfigWidget>()?._data ?? AppConfigData.defaultData;

  @override
  bool updateShouldNotify(AppThemeWidget oldWidget) => true;
}

class AppConfigData {
  /// 默认的全局配置
  static AppConfigData defaultData = AppConfigData();

  /// 全局字体
  String? fontFamily;

  /// 全局字体名字
  String get fontFamilyName => fontFamily == null || fontFamily == '' ? '系统字体' : fontFamily!;

  /// 如果[fontFamily]为空，那么会依次根据设置的字体列表去匹配相应的字体
  List<String>? fontFamilyFallback;

  /// 卡片圆角值
  double cardRadius;

  /// 按钮圆角值
  double buttonRadius;

  AppConfigData({
    String? fontFamily,
    List<String>? fontFamilyFallback,
    bool? centerTitle,
    this.cardRadius = 8,
    this.buttonRadius = 6,
  }) {
    this.fontFamily = fontFamily ?? FlutterFont.fontFamily;
    this.fontFamilyFallback = fontFamilyFallback ?? FlutterFont.fontFamilyFallback;
  }

  AppConfigData copyWith({
    String? fontFamily,
    List<String>? fontFamilyFallback,
    double? cardRadius,
    double? buttonRadius,
  }) {
    return AppConfigData(
      fontFamily: fontFamily ?? this.fontFamily,
      fontFamilyFallback: fontFamilyFallback ?? this.fontFamilyFallback,
      cardRadius: cardRadius ?? this.cardRadius,
      buttonRadius: buttonRadius ?? this.buttonRadius,
    );
  }
}
