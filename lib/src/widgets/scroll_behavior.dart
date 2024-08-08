import 'package:flutter/widgets.dart';

import '../utils/platform/platform.dart';

class CustomScrollBehavior extends ScrollBehavior {
  /// 自定义滚动行为
  const CustomScrollBehavior();

  @override
  Widget buildOverscrollIndicator(context, child, details) {
    // 如果是安卓平台，统一使用 M3 的过度滚动效果
    if (PlatformUtil.isAndroid) {
      return StretchingOverscrollIndicator(
        axisDirection: details.direction,
        child: child,
      );
    } else {
      return child;
    }
  }
}

class NoScrollBehavior extends CustomScrollBehavior {
  /// 不使用任何默认滚动条
  const NoScrollBehavior();

  @override
  Widget buildScrollbar(context, child, details) => child;
}
