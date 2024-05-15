import 'package:base_example/global.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';

import 'large_text.dart';

class DynamicFontPage extends HookWidget {
  DynamicFontPage({super.key});

  final List<String> fonts = [
    '系统字体',
    '谷歌字体',
    '在线字体',
  ];

  @override
  Widget build(BuildContext context) {
    AppDataController c = Get.find();
    final count = useState(0);
    final loading = useState(false);
    return Scaffold(
      appBar: AppBar(
        title: Text('当前字体 - ${context.appConfig.fontFamilyName}'),
        actions: [
          PopupMenuButton<int>(
            enableFeedback: true,
            offset: Offset(0, context.appbarHeight + 4),
            popUpAnimationStyle: AnimationStyle.noAnimation,
            icon: const Icon(Icons.language),
            onSelected: (value) async {
              if (value == 0) {
                await FontUtil.loadFont(FontModel.systemFont);
                AppDataController.of.config.value.fontFamily = FontUtil.fontFamily;
                AppDataController.of.config.refresh();
              } else if (value == 1) {
                await FontUtil.loadFont(FontModel.notoSansSC);
                AppDataController.of.config.value.fontFamily = FontUtil.fontFamily;
                AppDataController.of.config.refresh();
              } else if (value == 2) {
                loading.value = true;
                await FontUtil.loadFont(const FontModel(
                  fontFamily: 'LongCang',
                  fontUrl:
                      'https://fonts.gstatic.com/s/a/f626a05f45d156332017025fc68902a92f57f51ac57bb4a79097ee7bb1a97352.ttf',
                ));
                AppDataController.of.config.value.fontFamily = FontUtil.fontFamily;
                AppDataController.of.config.refresh();
                loading.value = false;
              }
            },
            itemBuilder: (context) {
              return fonts
                  .mapIndexed((index, font) => PopupMenuItem(
                        height: 40,
                        value: index,
                        child: Text(font),
                      ))
                  .toList();
            },
          ),
        ],
      ),
      body: buildScrollWidget(
        child: Center(
          child: Column(
            children: [
              ElevatedButton(
                onPressed: () {
                  count.value++;
                },
                child: Text('count: ${count.value}'),
              ),
              ElevatedButton(
                onPressed: loading.value
                    ? null
                    : () {
                        FontUtil.loadFont(FontModel.systemFont);
                        c.config.value.fontFamily = FontUtil.fontFamily;
                        c.config.refresh();
                      },
                child: const Text('加载系统字体'),
              ),
              ElevatedButton(
                onPressed: loading.value
                    ? null
                    : () {
                        FontUtil.loadFont(FontModel.initialFont);
                        c.config.value.fontFamily = FontUtil.fontFamily;
                        c.config.refresh();
                      },
                child: const Text('加载初始化字体'),
              ),
              ElevatedButton(
                onPressed: loading.value
                    ? null
                    : () {
                        FontUtil.loadFont(FontModel.notoSansSC);
                        c.config.value.fontFamily = FontUtil.fontFamily;
                        c.config.refresh();
                      },
                child: const Text('加载谷歌字体'),
              ),
              ElevatedButton(
                onPressed: loading.value
                    ? null
                    : () {
                        FontUtil.loadFont(FontModel.pingFangSC);
                        c.config.value.fontFamily = FontUtil.fontFamily;
                        c.config.refresh();
                      },
                child: const Text('加载苹方字体'),
              ),
              ElevatedButton(
                onPressed: loading.value
                    ? null
                    : () {
                        FontUtil.loadFont(FontModel.miSans);
                        c.config.value.fontFamily = FontUtil.fontFamily;
                        c.config.refresh();
                      },
                child: const Text('加载小米字体'),
              ),
              ElevatedButton(
                onPressed: loading.value
                    ? null
                    : () {
                        FontUtil.loadFont(FontModel.harmonyOS);
                        c.config.value.fontFamily = FontUtil.fontFamily;
                        c.config.refresh();
                      },
                child: const Text('加载鸿蒙字体'),
              ),
              ElevatedButton(
                onPressed: loading.value
                    ? null
                    : () async {
                        loading.value = true;
                        await FontUtil.loadFont(GoogleFontModels.notoSansSc([FontWeight.w400]));
                        c.config.value.fontFamily = FontUtil.fontFamily;
                        c.config.refresh();
                        loading.value = false;
                      },
                child: const Text('加载 notoSansSC font:400字体'),
              ),
              ElevatedButton(
                onPressed: loading.value
                    ? null
                    : () async {
                        loading.value = true;
                        await FontUtil.loadFont(GoogleFontModels.notoSansSc(FontWeight.values));
                        c.config.value.fontFamily = FontUtil.fontFamily;
                        c.config.refresh();
                        loading.value = false;
                      },
                child: const Text('加载 notoSansSC 完整字体'),
              ),
              ElevatedButton(
                onPressed: loading.value
                    ? null
                    : () async {
                        loading.value = true;
                        await FontUtil.loadFont(GoogleFontModels.longCang());
                        c.config.value.fontFamily = FontUtil.fontFamily;
                        c.config.refresh();
                        loading.value = false;
                      },
                child: const Text('加载 longCang 字体'),
              ),
              const SizedBox(height: 8),
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
              const Text(
                '正常: $_simpleText',
                style: TextStyle(
                  fontWeight: FontWeight.normal,
                ),
              ),
              const Text(
                '中等: $_simpleText',
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                ),
              ),
              const Text(
                '加粗: $_simpleText',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              ...FontWeight.values.map(
                (e) => Text(
                  '$e: $_simpleText',
                  style: TextStyle(
                    fontWeight: e,
                  ),
                ),
              ),
              const SizedBox(height: 8),
              ...FontWeight.values.map(
                (e) => ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(builder: (context) => LargeTextPage(fontWeight: e)));
                  },
                  child: Text('$e 大文本页面'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

const String _simpleText = 'Hello，你好呀，按钮，工具，启动，组件';

/// 谷歌在线字体
class GoogleFontModels {
  GoogleFontModels._();

  /// 谷歌在线字体通用字体
  static String _url(String fileHash) => 'https://fonts.gstatic.com/s/a/$fileHash.ttf';

  /// 谷歌中文字体
  static FontModel notoSansSc(List<FontWeight> fontWeights) {
    return FontModel(
      fontFamily: 'NotoSansSC',
      fontWeights: _GoogleFonts._notoSansSc.filterFromKeys((fontWeights).map((e) => e.value).toList()),
    );
  }

  static FontModel longCang() => FontModel(
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
