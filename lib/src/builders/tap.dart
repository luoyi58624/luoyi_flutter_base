import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:luoyi_dart_base/luoyi_dart_base.dart';

Timer? _timer;

class TapBuilder extends StatefulWidget {
  /// 按下事件构造器
  const TapBuilder({
    super.key,
    required this.builder,
    this.onTap,
    this.delay = 16,
    this.disabled = false,
  }) : assert(delay >= 0);

  final Widget Function(bool isTap) builder;

  final GestureTapCallback? onTap;

  /// 延迟多少毫秒更新点击状态，默认 16 毫秒。
  ///
  /// 提示：如果在极短的时间内多次调用setState，flutter只会触发一次更新，例如用户手指轻按、鼠标轻点，这里其中的时间间隔极短，
  /// 如果不设置一点延迟，那么依赖点击状态的动画可能会没有反应
  final int delay;

  /// 是否禁用，默认false
  final bool disabled;

  /// 根据上下文获取最近的点击状态
  static bool of(BuildContext context) => _TapInheritedWidget.of(context);

  @override
  State<TapBuilder> createState() => _TapBuilderState();
}

class _TapBuilderState extends State<TapBuilder> {
  bool isTap = false;

  @override
  Widget build(BuildContext context) {
    return _TapInheritedWidget(
      isTap: isTap,
      child: GestureDetector(
        onTap: widget.disabled ? null : widget.onTap,
        onTapDown: widget.disabled
            ? null
            : (e) {
                if (_timer != null) {
                  _timer!.cancel();
                  _timer = null;
                  update(false);
                  (() => update(true)).delay(16);
                } else {
                  update(true);
                }
              },
        onTapUp: widget.disabled
            ? null
            : (e) {
                _timer = () {
                  update(false);
                  _timer = null;
                }.delay(widget.delay);
              },
        onTapCancel: widget.disabled
            ? null
            : () {
                _timer = () {
                  update(false);
                  _timer = null;
                }.delay(widget.delay);
              },
        child: widget.builder(isTap),
      ),
    );
  }

  void update(bool value) {
    if (mounted && isTap != value) {
      setState(() {
        isTap = value;
      });
    }
  }
}

class _TapInheritedWidget extends InheritedWidget {
  const _TapInheritedWidget({
    required super.child,
    required this.isTap,
  });

  final bool isTap;

  static bool of(BuildContext context) {
    final _TapInheritedWidget? result =
        context.dependOnInheritedWidgetOfExactType<_TapInheritedWidget>();
    return result == null ? false : result.isTap;
  }

  @override
  bool updateShouldNotify(_TapInheritedWidget oldWidget) {
    return true;
  }
}
