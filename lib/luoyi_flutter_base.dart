library luoyi_flutter_base;

import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:localstorage/localstorage.dart';
import 'package:luoyi_flutter_font/luoyi_flutter_font.dart';
import 'package:mini_getx/mini_getx.dart';

import 'luoyi_flutter_base.dart';
import 'src/utils/platform/platform_web.dart' if (dart.library.io) 'src/utils/platform/platform_io.dart';
import 'src/utils/session_storage/web.dart' if (dart.library.io) 'src/utils/session_storage/io.dart';

export 'package:luoyi_dart_base/luoyi_dart_base.dart';

// 一个非常轻量的 key-value 本地存储，整个包的源代码不超过100行，不依赖任何本机插件
export 'package:localstorage/localstorage.dart' hide initLocalStorage, LocalStorage;

// 与 react-hook 类似，它可以节省大量 StatefulWidget 样板代码，你甚至可以使用它来实现双向绑定
export 'package:flutter_hooks/flutter_hooks.dart';

// 轻松地在行或列小部件内添加间隙，它会自动适配元素排列方向，不必使用 SizedBox 手动定义width、height来控制元素间隙
export 'package:gap/gap.dart';

part 'src/widgets/brightness.dart';

part 'src/apps/responsive.dart';

part 'src/apps/config.dart';

part 'src/apps/theme.dart';

part 'src/apps/typography.dart';

part 'src/builders/hover.dart';

part 'src/builders/tap.dart';

part 'src/commons/model.dart';

part 'src/extensions/color.dart';

part 'src/extensions/int.dart';

part 'src/hooks/getx.dart';

part 'src/utils/platform/platform.dart';

part 'src/utils/session_storage/session_storage.dart';

part 'src/utils/flutter.dart';

part 'src/utils/no_ripper.dart';

part 'src/utils/use_local_obs.dart';

part 'src/widgets/animation.dart';

part 'src/widgets/simple_widgets.dart';

const bool isWeb = kIsWeb;

/// 根节点导航key，使用前必须将它添加到App中
/// ```dart
/// MaterialApp(
///   navigatorKey: rootNavigatorKey,
/// );
/// ```
GlobalKey<NavigatorState> rootNavigatorKey = GlobalKey<NavigatorState>();

/// 根节点context
BuildContext get rootContext {
  assert(rootNavigatorKey.currentWidget != null, 'Please configured rootNavigatorKey before use rootContext');
  assert(rootNavigatorKey.currentWidget is Navigator,
      'Whether you right configured rootNavigatorKey? rootNavigatorKey not Navigator!');
  return rootNavigatorKey.currentContext!;
}

/// 初始化 LocalStorage 和 SessionStorage
Future<void> initStorage() async {
  await initLocalStorage();
  await _initSessionStorage();
}
