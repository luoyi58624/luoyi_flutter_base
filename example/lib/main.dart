import 'package:flutter/material.dart';
import 'package:luoyi_flutter_base/luoyi_flutter_base.dart';

import 'large_text.dart';

/// 简易状态管理，保存当前选择的字体
final ValueNotifier<String?> fontFamily = ValueNotifier<String?>(null);

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await FontUtil.init();
  fontFamily.value = FontUtil.fontFamily;
  runApp(const _App());
}

class _App extends StatelessWidget {
  const _App();

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: fontFamily,
      builder: (context, value, child) {
        return MaterialApp(
          theme: ThemeData(
            fontFamily: value,
            fontFamilyFallback: FontUtil.fontFamilyFallback,
            materialTapTargetSize: MaterialTapTargetSize.padded,
          ),
          home: const HomePage(),
        );
      },
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool loading = false;

  int count = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: ValueListenableBuilder(
          valueListenable: fontFamily,
          builder: (context, value, child) {
            return Text('动态字体 - ${value ?? '系统字体'}');
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    count++;
                  });
                },
                child: Text('count: $count'),
              ),
              ElevatedButton(
                onPressed: loading
                    ? null
                    : () {
                        FontUtil.loadFont(FontUtil.systemFont);
                        fontFamily.value = FontUtil.fontFamily;
                      },
                child: const Text('加载系统字体'),
              ),
              ElevatedButton(
                onPressed: loading
                    ? null
                    : () {
                        FontUtil.loadFont(FontUtil.initialFont);
                        fontFamily.value = FontUtil.fontFamily;
                      },
                child: const Text('加载初始化字体'),
              ),
              ElevatedButton(
                onPressed: loading
                    ? null
                    : () {
                        FontUtil.loadFont(FontUtil.notoSansSc());
                        fontFamily.value = FontUtil.fontFamily;
                      },
                child: const Text('加载谷歌字体'),
              ),
              ElevatedButton(
                onPressed: loading
                    ? null
                    : () async {
                        setState(() {
                          loading = true;
                        });
                        await FontUtil.loadFont(FontUtil.notoSansSc([FontWeight.w500]));
                        fontFamily.value = FontUtil.fontFamily;
                        setState(() {
                          loading = false;
                        });
                      },
                child: const Text('加载 notoSansSC font:500字体'),
              ),
              ElevatedButton(
                onPressed: loading
                    ? null
                    : () async {
                  setState(() {
                    loading = true;
                  });
                  await FontUtil.loadFont(FontUtil.notoSansSc([FontWeight.w700]));
                  fontFamily.value = FontUtil.fontFamily;
                  setState(() {
                    loading = false;
                  });
                },
                child: const Text('加载 notoSansSC font:700字体'),
              ),
              ElevatedButton(
                onPressed: loading
                    ? null
                    : () async {
                        setState(() {
                          loading = true;
                        });
                        await FontUtil.loadFont(FontUtil.notoSansSc(FontWeight.values));
                        fontFamily.value = FontUtil.fontFamily;
                        setState(() {
                          loading = false;
                        });
                      },
                child: const Text('加载 notoSansSC 所有字体'),
              ),
              ElevatedButton(
                onPressed: loading
                    ? null
                    : () async {
                        setState(() {
                          loading = true;
                        });
                        await FontUtil.loadFont(FontUtil.longCang());
                        fontFamily.value = FontUtil.fontFamily;
                        setState(() {
                          loading = false;
                        });
                      },
                child: const Text('加载 longCang 字体'),
              ),
              const SizedBox(height: 8),
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
