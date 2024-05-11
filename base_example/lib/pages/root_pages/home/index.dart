import 'package:base_example/pages/all_color.dart';
import 'package:base_example/pages/color.dart';
import 'package:base_example/pages/hook.dart';
import 'package:base_example/pages/root_pages/home/theme.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:luoyi_flutter_font/luoyi_flutter_font.dart';

import '../../../global.dart';
import '../../../widgets/button.dart';
import '../../button.dart';

class HomeRootPage extends StatefulWidget {
  const HomeRootPage({super.key});

  @override
  State<HomeRootPage> createState() => _HomeRootPageState();
}

class _HomeRootPageState extends State<HomeRootPage> {
  int count = 0;
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).bottomLabelHome),
        actions: [
          IconButton(
            onPressed: () {
              AppDataController.of.themeMode.value = context.isDarkMode ? ThemeMode.light : ThemeMode.dark;
            },
            icon: Icon(context.isDarkMode ? Icons.dark_mode : Icons.light_mode),
          ),
          Obx(
            () => IconButton(
              onPressed: () {
                AppDataController.of.config.value = AppDataController.of.config.value
                    .copyWith(useMaterial3: !AppDataController.of.config.value.useMaterial3);
              },
              icon: Icon(
                  AppDataController.of.config.value.useMaterial3 ? Icons.looks_3_outlined : Icons.looks_two_outlined),
            ),
          ),
          PopupMenuButton<String>(
            enableFeedback: true,
            offset: Offset(0, context.appbarHeight + 4),
            popUpAnimationStyle: AnimationStyle.noAnimation,
            icon: const Icon(Icons.translate),
            onSelected: (value) {
              S.load(Locale(value));
              WidgetsBinding.instance.reassembleApplication();
            },
            itemBuilder: (context) {
              return GlobalController.of.locale.keys
                  .map((key) => PopupMenuItem(
                        height: 40,
                        value: GlobalController.of.locale[key]!,
                        child: Text(key),
                      ))
                  .toList();
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              const SizedBox(height: 8),
              SelectableText(S.of(context).helloWorld),
              ...FontWeight.values.map(
                (e) => Text(
                  '$e: Hello，你好呀，按钮，工具，启动，组件',
                  style: TextStyle(
                    fontWeight: e,
                  ),
                ),
              ),
              // const SizedBox(height: 8),
              // ...FontWeight.values.map(
              //   (e) => Text(
              //     '$e: Hello，你好呀，按钮，工具，启动',
              //     style: GoogleFonts.notoSansSc(
              //       textStyle: TextStyle(
              //         fontWeight: e,
              //       ),
              //     ),
              //   ),
              // ),
              // const SizedBox(height: 8),
              // Text(
              //   'Hello，你好呀，按钮，工具，启动',
              //   style: GoogleFonts.notoSansSc(),
              // ),
              // const SizedBox(height: 8),
              // Text(
              //   'Hello，你好呀，按钮，工具，启动',
              //   style: GoogleFonts.notoSansSc(
              //     textStyle: const TextStyle(
              //       fontWeight: FontWeight.w500,
              //     ),
              //   ),
              // ),
              // const SizedBox(height: 8),
              // Text(
              //   'Hello，你好呀，按钮，工具，启动',
              //   style: GoogleFonts.longCang(
              //     textStyle: const TextStyle(
              //       fontWeight: FontWeight.w500,
              //     ),
              //   ),
              // ),
              // const SizedBox(height: 8),
              // Text(
              //   'Hello，你好呀，按钮，工具，启动',
              //   style: GoogleFonts.notoSansJp(
              //     textStyle: const TextStyle(
              //       fontWeight: FontWeight.w500,
              //     ),
              //   ),
              // ),
              // const SizedBox(height: 8),
              // const Text(
              //   'Hello，你好呀，按钮，工具，启动',
              //   style: TextStyle(
              //     fontFamily: 'NotoSansSC',
              //     fontWeight: FontWeight.w500,
              //   ),
              // ),
              const SizedBox(height: 8),
              ButtonWidget(
                onPressed: () {
                  context.push(const ButtonTestPage());
                },
                child: const Text('button测试页面'),
              ),
              const SizedBox(height: 8),
              ButtonWidget(
                onPressed: () {
                  context.push(const HookTestPage());
                },
                child: const Text('hook测试页面'),
              ),
              const SizedBox(height: 8),
              ButtonWidget(
                onPressed: () {
                  context.push(const ColorTestPage());
                },
                child: const Text('color测试页面'),
              ),
              const SizedBox(height: 8),
              ButtonWidget(
                onPressed: () {
                  context.push(const AllColorTestPage());
                },
                child: const Text('all color测试页面'),
              ),
              const SizedBox(height: 8),
              ElevatedButton(
                onPressed: loading
                    ? null
                    : () async {
                        await FlutterFont.loadFont(FlutterFontModel.systemFont, false);
                        AppDataController.of.config.value.fontFamily = FlutterFont.fontFamily;
                        AppDataController.of.config.refresh();
                      },
                child: const Text('加载系统字体'),
              ),
              const SizedBox(height: 8),
              ElevatedButton(
                onPressed: loading
                    ? null
                    : () async {
                        await FlutterFont.loadFont(FlutterFontModel.initialFont, false);
                        AppDataController.of.config.value.fontFamily = FlutterFont.fontFamily;
                        AppDataController.of.config.refresh();
                      },
                child: const Text('加载初始化字体'),
              ),
              const SizedBox(height: 8),
              ElevatedButton(
                onPressed: loading
                    ? null
                    : () async {
                        await FlutterFont.loadFont(FlutterFontModel.notoSansSC);
                        AppDataController.of.config.value.fontFamily = FlutterFont.fontFamily;
                        AppDataController.of.config.refresh();
                      },
                child: const Text('加载资产包中文字体'),
              ),
              const SizedBox(height: 8),
              ElevatedButton(
                onPressed: loading
                    ? null
                    : () async {
                        setState(() {
                          loading = true;
                        });
                        await FlutterFont.loadFont(const FlutterFontModel(
                          fontFamily: 'LongCang',
                          fontUrl:
                              'https://fonts.gstatic.com/s/a/f626a05f45d156332017025fc68902a92f57f51ac57bb4a79097ee7bb1a97352.ttf',
                        ));
                        AppDataController.of.config.value.fontFamily = FlutterFont.fontFamily;
                        AppDataController.of.config.refresh();
                        setState(() {
                          loading = false;
                        });
                      },
                child: const Text('加载 longCang 字体'),
              ),
              const SizedBox(height: 8),
              ElevatedButton(
                onPressed: loading
                    ? null
                    : () async {
                        setState(() {
                          loading = true;
                        });
                        await FlutterFont.loadFont(GoogleFontModels.notoSansSc(FontWeight.values));
                        AppDataController.of.config.value =
                            AppDataController.of.config.value.copyWith(fontFamily: FlutterFont.fontFamily);
                        setState(() {
                          loading = false;
                        });
                      },
                child: const Text('加载在线谷歌中文字体'),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.push(const ThemePage());
        },
        child: const Icon(Icons.color_lens),
      ),
    );
  }
}

/// 谷歌在线字体
class GoogleFontModels {
  GoogleFontModels._();

  /// 谷歌在线字体通用字体
  static String _url(String fileHash) => 'https://fonts.gstatic.com/s/a/$fileHash.ttf';

  /// 谷歌中文字体
  static FlutterFontModel notoSansSc(List<FontWeight> fontWeights) {
    return FlutterFontModel(
      fontFamily: 'NotoSansSC',
      fontWeights: _GoogleFonts._notoSansSc.filterFromKeys((fontWeights).map((e) => e.value).toList()),
    );
  }

  static FlutterFontModel longCang() => FlutterFontModel(
        fontFamily: 'LongCang',
        fontUrl: _url('f626a05f45d156332017025fc68902a92f57f51ac57bb4a79097ee7bb1a97352'),
      );
}

class _GoogleFonts {
  _GoogleFonts._();

  static String _url(String fileHash) => GoogleFontModels._url(fileHash);

  static final Map<int, String> _notoSansSc = {
    FontWeight.w100.value: _url('f1b8c2a287d23095abd470376c60519c9ff650ae8744b82bf76434ac5438982a'),
    FontWeight.w200.value: _url('cba9bb657b61103aeb3cd0f360e8d3958c66febf59fbf58a4762f61e52015d36'),
    FontWeight.w300.value: _url('4cdbb86a1d6eca92c7bcaa0c759593bc2600a153600532584a8016c24eaca56c'),
    FontWeight.w400.value: _url('eacedb2999b6cd30457f3820f277842f0dfbb28152a246fca8161779a8945425'),
    FontWeight.w500.value: _url('5383032c8e54fc5fa09773ce16483f64d9cdb7d1f8e87073a556051eb60f8529'),
    FontWeight.w600.value: _url('85c00dac0627c2c0184c24669735fad5adbb4f150bcb320c05620d46ed086381'),
    FontWeight.w700.value: _url('a7a29b6d611205bb39b9a1a5c2be5a48416fbcbcfd7e6de98976e73ecb48720b'),
    FontWeight.w800.value: _url('038de57b1dc5f6428317a8b0fc11984789c25f49a9c24d47d33d2c03e3491d28'),
    FontWeight.w900.value: _url('501582a5e956ab1f4d9f9b2d683cf1646463eea291b21f928419da5e0c5a26eb'),
  };
}

extension DartMapExtension<K, V> on Map<K, V> {
  /// 根据keys集合，返回一个新的Map
  Map<K, V> filterFromKeys(List<K> keys) {
    Map<K, V> newMap = {};
    for (K key in keys) {
      newMap[key] = this[key] as V;
    }
    return newMap;
  }
}
