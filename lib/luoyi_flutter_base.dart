library luoyi_flutter_base;

import 'dart:async';
import 'dart:math' as math;

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:luoyi_dart_base/luoyi_dart_base.dart';
import 'package:mini_getx/mini_getx.dart';

export 'package:luoyi_dart_base/luoyi_dart_base.dart';

export 'package:mini_getx/mini_getx.dart';

// flutter官方国际化库
export 'package:flutter_localizations/flutter_localizations.dart';

part 'src/commons/theme.dart';

part 'src/commons/config.dart';

part 'src/builders/hover.dart';

part 'src/builders/tap.dart';

part 'src/commons/color.dart';

part 'src/commons/model.dart';

part 'src/extensions/color.dart';

part 'src/extensions/drawer.dart';

part 'src/extensions/router.dart';

part 'src/extensions/string.dart';

part 'src/pages/simple_page.dart';

part 'src/utils/animation.dart';

part 'src/utils/async.dart';

part 'src/utils/device.dart';

part 'src/utils/flutter.dart';

part 'src/utils/font.dart';

part 'src/utils/theme_data.dart';

part 'src/extensions/modal.dart';

part 'src/utils/no_ripper.dart';

part 'src/utils/platform.dart';

part 'src/widgets/animation.dart';

part 'src/app.dart';

part 'src/widgets/badge.dart';

part 'src/widgets/flex_wrap.dart';

part 'src/widgets/scroll_ripper.dart';

part 'src/widgets/simple_widgets.dart';

part 'src/widgets/form/form.dart';

part 'src/widgets/form/form_item.dart';

part 'src/widgets/form/form_text_field.dart';

part 'src/widgets/cupertino/list_group.dart';

part 'src/widgets/cupertino/list_tile.dart';

/// 初始化App
Future<void> initApp() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DeviceUtil._init();
  FontUtil._init();
}
