part of '../../luoyi_flutter_base.dart';

/// [AppData]响应式控制器，基于[Getx]，使用前需要先注入 (可选)
class AppDataController extends GetxController {
  AppDataController({
    ThemeMode? themeMode,
    AppThemeData? theme,
    AppThemeData? darkTheme,
    AppConfigData? config,
  }) {
    _init(
      themeMode ?? ThemeMode.system,
      theme ?? AppThemeData.theme,
      darkTheme ?? AppThemeData.darkTheme,
      config ?? AppConfigData.config,
    );
  }

  static AppDataController? get maybeOf => Get.findOrNull();

  static AppDataController get of {
    assert(maybeOf != null, '请先执行Get.put(AppDataController())');
    return maybeOf!;
  }

  late final count = useLocalObs(0, 'count', expire: 10);
  late final Rx<ThemeMode> themeMode;
  late final Rx<AppThemeData> theme;
  late final Rx<AppThemeData> darkTheme;
  late final Rx<AppConfigData> config;

  void _init(ThemeMode $themeMode, AppThemeData $theme, AppThemeData $darkTheme, AppConfigData $config) {
    themeMode = $themeMode.obs;
    theme = $theme.obs;
    darkTheme = $darkTheme.obs;
    config = $config.obs;
  }

  void setTheme(BuildContext context, AppThemeData themeData) {
    if (context.isDarkMode) {
      darkTheme.value = themeData;
    } else {
      theme.value = themeData;
    }
  }
}
