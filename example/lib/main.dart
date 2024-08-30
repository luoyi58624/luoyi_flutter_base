import 'package:example/05.dart';
import 'package:example/animate_hover_test.dart';
import 'package:flutter/material.dart';
import 'package:luoyi_flutter_base/luoyi_flutter_base.dart';

void main() {
  runApp(const _App());
}

final isDark = Obs(false);

class _App extends StatelessWidget {
  const _App();

  @override
  Widget build(BuildContext context) {
    return ObsBuilder(
      builder: (context) {
        return MaterialApp(
            navigatorKey: GlobalConfig.navigatorKey,
            home: const HomePage(),
            theme: ThemeData(
              brightness: isDark.value ? Brightness.dark : Brightness.light,
            ),
            darkTheme: ThemeData(brightness: Brightness.dark),
            builder: (context, child) {
              return Material(
                child: Overlay(initialEntries: [
                  OverlayEntry(builder: (context) {
                    return child!;
                  }),
                ]),
              );
            });
      }
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(''),
      ),
      body: Column(
        children: [
          ListTile(
            title: const Text('Example5'),
            onTap: () {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => const Example5()));
            },
          ),
          ListTile(
            title: const Text('子页面'),
            onTap: () {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => const _ChildPage()));
            },
          ),
          ListTile(
            title: const Text('动画Hover'),
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const AnimateHoverTestPage()));
            },
          ),
        ],
      ),
    );
  }
}

void watchFun(newValue, oldValue) {
  i(newValue, 'watchFun');
}

class _ChildPage extends StatefulWidget {
  const _ChildPage();

  @override
  State<_ChildPage> createState() => _ChildPageState();
}

class _ChildPageState extends State<_ChildPage> with TickerProviderStateMixin {
  late final flag = Obs(false, watch: (newValue, oldValue) {
    if (newValue) {
      width.value = 200;
      height.value = 200;
      color.value = Colors.red;
    } else {
      width.value = 100;
      height.value = 100;
      color.value = Colors.green;
    }
  });
  late final width = AnimateObs(100.0, vsync: this);
  late final height = AnimateObs(100.0, vsync: this);

  // late final size = AnimateObs(100.0, vsync: this);
  late final color = AnimateObs(
    Colors.green,
    vsync: this,
    tweenBuilder: () => ColorTween(),
  );

  @override
  void dispose() {
    width.dispose();
    height.dispose();
    color.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Example'),
        actions: [
          ObsBuilder(builder: (context) {
            return Switch(
              value: flag.value,
              onChanged: (v) {
                flag.value = v;
              },
            );
          })
        ],
      ),
      body: Column(
        children: [
          HoverBuilder(builder: (context) {
            return ObsBuilder(
              watch: [width, color],
              builder: (context) {
                return Container(
                  width: width.animation.value,
                  height: height.animation.value,
                  decoration: BoxDecoration(
                    color: color.animation.value,
                    // color: color.on(HoverBuilder.of(context)),
                  ),
                );
              },
            );
          }),
        ],
      ),
    );
  }
}

extension AnimateObsExt on AnimateObs<Color?> {
  /// 根据事件状态返回新的颜色
  Color on(bool flag, {int scale = 10, Color? color}) {
    if (flag) {
      value = color ?? value!.deepen(scale);
    } else {
      controller.reverse();
    }
    return animation.value!;
  }
}
