part of 'index.dart';

class AppController extends GetxController {
  AppController._();

  static AppController get of => Get.find();
  late final themeMode = useLocalObs<ThemeMode>(
    ThemeMode.system,
    'theme_mode',
    serializeFun: (model) => model.index.toString(),
    deserializeFun: (json) => ThemeMode.values[int.parse(json)],
  );

  late final Rx<AppConfigData> config;
  late final selectPresetTheme = useLocalObs(0, 'selected_preset_theme');

  AppConfigData getAppConfig(int index) {
    if (index == 0) return AppConfigData.config;
    if (index == 1) return AppConfigData.m2Config;
    if (index == 2) return AppConfigData.m2FlatConfig;
    if (index == 3) return AppConfigData.m3Config;
    if (index == 4) return AppConfigData.m3FlatConfig;
    return AppConfigData.config;
  }

  @override
  void onInit() {
    super.onInit();
    config = getAppConfig(selectPresetTheme.value).obs;
    ever(selectPresetTheme, (index) {
      config.value = getAppConfig(index);
    });
  }
}
