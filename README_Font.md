优化flutter中文字体渲染问题，动态从网络加载字体，此库仅作用于加载全局字体

### 安装依赖

```
flutter pub add luoyi_flutter_font
```

### 初始化默认字体

```dart
import 'package:flutter/material.dart';
import 'package:luoyi_flutter_font/luoyi_flutter_font.dart';

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
```

- pubspec.yaml添加谷歌中文字体，这是裁剪后的谷歌 NotoSansSC 字体，包含常用的3500个中文汉字

```yaml
flutter:
  uses-material-design: true
  fonts:
    - family: NotoSansSC
      fonts:
        - asset: packages/luoyi_flutter_font/fonts/NotoSansSC/NotoSansSC-Medium.ttf
        - asset: packages/luoyi_flutter_font/fonts/NotoSansSC/NotoSansSC-Bold.ttf
```

### 加载动态字体

```dart
void test() {
  // 调用loadFont函数动态加载字体，根据结果刷新页面状态
  // 加载系统字体
  bool result = FontUtil.loadFont(FontModel.systemFont);
  if (result == true) {
    fontFamily.value = FontUtil.fontFamily;
  }

  // 加载资产包中的字体，不要定义 fontUrl 和 fontWeights
  FontUtil.loadFont(FontModel(
    fontFamily: 'my_font',
  ));

  // 加载在线字体
  FontUtil.loadFont(FontModel(
    fontFamily: 'LongCang',
    fontUrl: 'https://fonts.gstatic.com/s/a/f626a05f45d156332017025fc68902a92f57f51ac57bb4a79097ee7bb1a97352.ttf',
  ));

  // 加载多种字重在线字体
  FontUtil.loadFont(FontModel(
    fontFamily: 'NotoSansSC',
    fontWeights: {
      400: 'https://fonts.gstatic.com/s/a/eacedb2999b6cd30457f3820f277842f0dfbb28152a246fca8161779a8945425.ttf',
      500: 'https://fonts.gstatic.com/s/a/5383032c8e54fc5fa09773ce16483f64d9cdb7d1f8e87073a556051eb60f8529.ttf',
      700: 'https://fonts.gstatic.com/s/a/a7a29b6d611205bb39b9a1a5c2be5a48416fbcbcfd7e6de98976e73ecb48720b.ttf',
    },
  ));
}
```


