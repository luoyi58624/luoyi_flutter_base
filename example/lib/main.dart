import 'package:example/global.dart';
import 'package:example/utils/theme_data_builder.dart';
import 'package:flutter/material.dart';

import 'pages/home.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await FontUtil.init();
  initController();
  runApp(const _App());
}

class _App extends StatelessWidget {
  const _App();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: buildM2ThemeData(Brightness.light, ElTheme.defaultThemeData),
      home: const HomePage(),
      builder: (context, child) => ElTheme(
        data: ElThemeData(
            config: ElConfigData(
                // scrollConfiguration:
                )),
        child: child!,
      ),
    );
  }
}
