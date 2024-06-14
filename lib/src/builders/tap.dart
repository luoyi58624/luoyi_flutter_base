import 'dart:async';
import 'dart:math';

import 'package:flutter/widgets.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:luoyi_dart_base/luoyi_dart_base.dart';
import 'package:luoyi_flutter_base/luoyi_flutter_base.dart';

Timer? _timer;

class TapBuilder extends StatefulWidget {
  /// 按下事件构造器
  TapBuilder({
    super.key,
    required this.builder,
    this.onTap,
    int? delay,
    this.disabled = false,
  }) {
    assert(delay == null || delay >= 0);
    // 在移动端，无论你是否应用动画，延迟100毫秒都能令状态变更效果更明显，
    // 因为移动端滚动列表下，按下、释放事件之间的间隔极短。几乎为0，这样你的点击效果基本无效。
    this.delay = delay ?? (PlatformUtil.isMobile ? 100 : 0);
  }

  final Widget Function(bool isTap) builder;

  final GestureTapCallback? onTap;

  /// 延迟多少毫秒更新点击状态，如果你设置了此参数，当触发 onTapDown 时将记录当前时间戳，
  /// 然后取 onTapUp 触发的时间戳的差值延迟更新 isTap 状态，该属性一般用来配合过渡动画一起使用,
  /// 如果你设置了300毫秒的过渡动画，若想等动画加载完再改变状态只需设置300毫秒的延迟即可，
  /// 否则动画只执行了100毫秒就被迫重置
  late final int delay;

  /// 是否禁用，默认false
  final bool disabled;

  /// 根据上下文获取最近的点击状态
  static bool of(BuildContext context) => _TapInheritedWidget.of(context);

  @override
  State<TapBuilder> createState() => _TapBuilderState();
}

class _TapBuilderState extends State<TapBuilder> {
  bool isTap = false;
  int? _time;

  @override
  Widget build(BuildContext context) {
    return _TapInheritedWidget(
      isTap: isTap,
      child: GestureDetector(
        onTap: widget.disabled ? null : widget.onTap,
        onTapDown: widget.disabled
            ? null
            : (e) {
                _time = currentMilliseconds;
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
                // i(currentMilliseconds - _time!);
                // i(max(widget.delay - (currentMilliseconds - _time!), 0));
                _timer = () {
                  update(false);
                  _timer = null;
                }.delay(max(widget.delay - (currentMilliseconds - _time!), 0));
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
