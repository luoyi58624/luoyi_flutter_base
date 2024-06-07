library luoyi_flutter_base;

import 'dart:async';
import 'package:localstorage/localstorage.dart';

import 'src/utils/session_storage/session_storage.dart';

export 'package:luoyi_dart_base/luoyi_dart_base.dart';
export 'package:flutter_hooks/flutter_hooks.dart';
export 'package:gap/gap.dart';
export 'package:super_sliver_list/super_sliver_list.dart';

// 一个非常轻量的 key-value 本地存储，整个包的源代码不超过100行，不依赖任何本机插件
export 'package:localstorage/localstorage.dart' show localStorage;
export 'src/utils/session_storage/session_storage.dart' show sessionStorage;

export 'src/widgets/animation.dart';

/// 初始化 LocalStorage 和 SessionStorage
Future<void> initStorage() async {
  await initLocalStorage();
  await initSessionStorage();
}
