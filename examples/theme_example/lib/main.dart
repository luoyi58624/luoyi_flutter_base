import 'package:theme_example/global.dart';

import 'pages/home.dart';

void main() async {
  await initApp();
  initController();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    AppController c = Get.find();
    return Obx(() {
      return AppWidget(
        data: c.config.value,
        child: Builder(builder: (context) {
          return Obx(() {
            return MaterialApp(
              themeMode: c.themeMode.value,
              theme: AppWidget.buildThemeData(context),
              darkTheme: AppWidget.buildThemeData(context, brightness: Brightness.dark),
              home: const HomePage(),
            );
          });
        }),
      );
    });
  }
}
