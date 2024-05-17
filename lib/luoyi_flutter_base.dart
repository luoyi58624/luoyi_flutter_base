library luoyi_flutter_base;

import 'dart:async';
import 'dart:collection';
import 'dart:convert';
import 'dart:math' as math;

import 'package:device_info_plus/device_info_plus.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:localstorage/localstorage.dart';
import 'package:luoyi_dart_base/luoyi_dart_base.dart';
import 'package:luoyi_flutter_base/src/plugins/http/interceptor/cache.dart';
import 'package:mini_getx/mini_getx.dart';

import 'src/utils/session_storage/web.dart' if (dart.library.io) 'src/utils/session_storage/io.dart';
import 'src/utils/font/web.dart' if (dart.library.io) 'src/utils/font/io.dart';

export 'src/plugins/http/http.dart';

export 'package:luoyi_dart_base/luoyi_dart_base.dart';

/// flutter国际化
export 'package:flutter_localizations/flutter_localizations.dart';

/// dart官方增强List、Map库
export 'package:collection/collection.dart';

/// 一个非常轻量的 key-value 本地存储，整个包的源代码不超过100行，不依赖任何本机插件
/// ```dart
/// localStorage.setItem('name', 'xxx');
/// localStorage.getItem('name');
/// ```
export 'package:localstorage/localstorage.dart' hide initLocalStorage, LocalStorage;

/// 轻松地在行或列小部件内添加间隙，它会自动适配元素排列方向，是 SizedBox 的替代品
/// ```dart
/// Column(
///   children: [
///     Text(''),
///     const Gap(4),
///     Text(''),
///   ],
/// )
/// ```
export 'package:gap/gap.dart';

/// ListView、SliverListView增强插件，api和官方一样，支持高性能渲染不定高子元素列表，高性能拖动滚动条滚动
export 'package:super_sliver_list/super_sliver_list.dart';

/// 与 react-hook 类似，它可以节省大量 StatefulWidget 样板代码，你甚至可以使用它来实现双向绑定 (实用性远超react-hook)
export 'package:flutter_hooks/flutter_hooks.dart';

/// 优化tab左右滑动，官方的不跟手
export 'package:extended_tabs/extended_tabs.dart';

part 'src/app/app.dart';

part 'src/app/config.dart';

part 'src/app/theme.dart';

part 'src/app/extension.dart';

part 'src/builders/hover.dart';

part 'src/builders/tap.dart';

part 'src/commons/color.dart';

part 'src/commons/model.dart';

part 'src/extensions/base.dart';

part 'src/extensions/drawer.dart';

part 'src/extensions/router.dart';

part 'src/hooks/getx.dart';

part 'src/pages/simple_page.dart';

part 'src/extensions/modal.dart';

part 'src/utils/font/font.dart';

part 'src/utils/font/model.dart';

part 'src/utils/session_storage/session_storage.dart';

part 'src/utils/animation.dart';

part 'src/utils/async.dart';

part 'src/utils/device.dart';

part 'src/utils/flutter.dart';

part 'src/utils/loading.dart';

part 'src/utils/no_ripper.dart';

part 'src/utils/platform.dart';

part 'src/utils/toast.dart';

part 'src/utils/use_local_obs.dart';

part 'src/widgets/animation.dart';

part 'src/widgets/badge.dart';

part 'src/widgets/exit_intercept.dart';

part 'src/widgets/flex_wrap.dart';

part 'src/widgets/flexible_title.dart';

part 'src/widgets/hide_keyboard.dart';

part 'src/widgets/restart_app.dart';

part 'src/widgets/scroll_ripper.dart';

part 'src/widgets/simple_widgets.dart';

part 'src/widgets/sliver.dart';

part 'src/widgets/tag.dart';

part 'src/widgets/tap_animate.dart';

part 'src/widgets/form/form.dart';

part 'src/widgets/form/form_item.dart';

part 'src/widgets/form/form_text_field.dart';

part 'src/widgets/cupertino/list_group.dart';

part 'src/widgets/cupertino/list_tile.dart';

/// 根节点导航key
GlobalKey<NavigatorState>? _rootNavigatorKey;

/// 根节点context
BuildContext get _rootContext {
  assert(_rootNavigatorKey != null, '请在 initApp 函数中传递rootNavigatorKey');
  return _rootNavigatorKey!.currentContext!;
}

List<String>? _fontFamilyFallback;

/// 初始化App一些通用配置
/// * rootNavigatorKey 全局导航key，注意：如果不传递则无法使用部分api
Future<void> initApp({
  GlobalKey<NavigatorState>? rootNavigatorKey,
  bool initStorage = true,
  bool initHttpCache = true,
  bool initFont = true,
}) async {
  WidgetsFlutterBinding.ensureInitialized();
  _rootNavigatorKey = rootNavigatorKey;
  // 初始化本地存储
  if (initStorage) {
    await initLocalStorage();
    await initSessionStorage();
  }
  // 初始化设备信息
  await DeviceUtil._init();
  // 初始化字体
  if (initFont) {
    _fontFamilyFallback = await FontUtil.init();
    await FontUtil.initSystemFontWeight();
  }
  // 初始化http缓存拦截器
  if (initHttpCache) await CacheInterceptor.init();
}
