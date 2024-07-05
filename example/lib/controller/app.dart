part of 'index.dart';

class AppController extends GetxController {
  AppController._();

  static AppController get of => Get.find();

  late final themeMode = ThemeMode.system.obs;

  // late final themeMode = useLocalObs<ThemeMode>(
  //   ThemeMode.system,
  //   'theme_mode',
  //   serializeFun: (model) => model.index.toString(),
  //   deserializeFun: (json) => ThemeMode.values[int.parse(json)],
  // );
}
