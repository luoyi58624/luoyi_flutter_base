part of '../luoyi_flutter_base.dart';

extension AppDataExtension on BuildContext {
  /// 当前主题数据
  FlutterThemeData get currentThemeData =>
      Theme.of(this).extension<FlutterThemeData>() ??
      (isDarkMode ? FlutterThemeData.darkTheme : FlutterThemeData.theme);

  /// 全局配置数据
  FlutterConfigData get configData => AppData.maybeOf(this)?.config ?? FlutterConfigData.config;

  /// Appbar高度
  double get appbarHeight =>
      configData.useMaterial3 ? configData.m3ConfigData.appbarHeight : configData.m2ConfigData.appbarHeight;
}

class AppData extends InheritedWidget {
  /// App全局数据共享，一般配合[ThemeDataUtil]工具类构建主题，该组件可选，如果不提供，则使用默认实例构建主题
  const AppData({
    super.key,
    required super.child,
    required this.theme,
    required this.darkTheme,
    required this.config,
  });

  /// 亮色主题
  final FlutterThemeData theme;

  /// 暗色主题
  final FlutterThemeData darkTheme;

  /// 全局配置
  final FlutterConfigData config;

  static AppData? maybeOf(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<AppData>();
  }

  static AppData of(BuildContext context) {
    final AppData? result = maybeOf(context);
    assert(result != null, 'No AppData found in context');
    return result!;
  }

  @override
  bool updateShouldNotify(AppData oldWidget) {
    return true;
  }
}

/// [AppData]响应式控制器，基于[Getx] (可选)
class AppDataController extends GetxController {
  AppDataController({
    ThemeMode? themeMode,
    FlutterThemeData? theme,
    FlutterThemeData? darkTheme,
    FlutterConfigData? config,
  }) {
    _init(
      themeMode ?? ThemeMode.system,
      theme ?? FlutterThemeData.theme,
      darkTheme ?? FlutterThemeData.darkTheme,
      config ?? FlutterConfigData.config,
    );
  }

  static AppDataController of = Get.find();
  late final Rx<ThemeMode> themeMode;
  late final Rx<FlutterThemeData> theme;
  late final Rx<FlutterThemeData> darkTheme;
  late final Rx<FlutterConfigData> config;

  void _init(ThemeMode $themeMode, FlutterThemeData $theme, FlutterThemeData $darkTheme, FlutterConfigData $config) {
    themeMode = $themeMode.obs;
    theme = $theme.obs;
    darkTheme = $darkTheme.obs;
    config = $config.obs;
  }
}
