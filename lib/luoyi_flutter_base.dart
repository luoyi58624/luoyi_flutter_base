library luoyi_flutter_base;

import 'dart:async';
import 'dart:convert';
import 'dart:math' as math;

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
import 'package:luoyi_flutter_font/luoyi_flutter_font.dart';
import 'package:mini_getx/mini_getx.dart';

export 'src/plugins/http/dio.dart';

export 'package:luoyi_dart_base/luoyi_dart_base.dart';

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

part 'src/app/app.dart';

part 'src/app/extension.dart';

part 'src/app/controller.dart';

part 'src/app/config/config.dart';

part 'src/app/config/m2_config.dart';

part 'src/app/config/m3_config.dart';

part 'src/app/theme/theme.dart';

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

part 'src/utils/animation.dart';

part 'src/utils/async.dart';

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

Future<void> initApp() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initLocalStorage();
}
