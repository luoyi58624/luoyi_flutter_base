import 'dart:async';
import 'dart:math';

import 'package:flutter/widgets.dart';
import 'package:luoyi_flutter_base/luoyi_flutter_base.dart';

class TapBuilder extends StatefulWidget {
  /// 点击事件构建器
  const TapBuilder({
    super.key,
    required this.builder,
    this.onTap,
    this.disabled = false,
    this.enableAnimate = false,
    this.duration = const Duration(milliseconds: 100),
    this.curve = Curves.linear,
  });

  final WidgetBuilder builder;

  /// 点击事件
  final GestureTapCallback? onTap;

  /// 是否禁用，默认false
  final bool disabled;

  /// 是否开启动画，默认 false，如果使用动画小部件，那么不需要使用 TapBuilder 的动画。
  final bool enableAnimate;

  /// 动画时间，每次按下时都会执行一次动画，你可以通过 TapBuilder.t(context) 获取当前动画插值，
  /// 如果 [enableAnimate] 没有开启，那么此属性会作为取消点击事件的延迟时间，
  /// 当用户快速地轻点鼠标时，设置一定的延迟时间可以让点击效果更加明显。
  final Duration duration;

  /// 动画曲线
  final Curve curve;

  /// 动画插值
  static double t(BuildContext context) =>
      _TapInheritedWidget.of(context)?.t ?? 0.0;

  /// 根据上下文获取最近的点击状态
  static bool of(BuildContext context) =>
      _TapInheritedWidget.of(context)?.isTap ?? false;

  @override
  State<TapBuilder> createState() => _TapBuilderState();
}

class _TapBuilderState extends State<TapBuilder>
    with SingleTickerProviderStateMixin {
  bool isTap = false;
  int? _time;
  Timer? _timer;

  late AnimationController controller;
  final Tween tween = Tween(begin: 0.0, end: 1.0);
  late Animation animation =
      tween.animate(CurvedAnimation(parent: controller, curve: widget.curve));

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      vsync: this,
      duration: widget.duration,
    );

    controller.addListener(() {
      setState(() {});
    });
  }

  @override
  void didUpdateWidget(covariant TapBuilder oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.duration != oldWidget.duration) {
      controller.duration = widget.duration;
    }
    if (widget.curve != oldWidget.curve) {
      animation = tween.animate(CurvedAnimation(
        parent: controller,
        curve: widget.curve,
      ));
    }
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
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
              _timer = () {
                update(false);
                _timer = null;
              }.delay(
                max(
                  widget.duration.inMilliseconds -
                      (currentMilliseconds - _time!),
                  0,
                ),
              );
            },
      onTapCancel: widget.disabled
          ? null
          : () {
              _timer = () {
                update(false);
                _timer = null;
              }.delay(widget.duration.inMilliseconds);
            },
      child: _TapInheritedWidget(
        animation.value,
        isTap,
        child: Builder(builder: (context) {
          return widget.builder(context);
        }),
      ),
    );
  }

  void update(bool value) {
    if (mounted && isTap != value) {
      if (widget.enableAnimate) {
        if (controller.duration == Duration.zero) {
          controller.duration = widget.duration;
        }
      } else {
        if (controller.duration != Duration.zero) {
          controller.duration = Duration.zero;
        }
      }
      if (value) {
        isTap = true;
        animation = tween
            .animate(CurvedAnimation(parent: controller, curve: widget.curve));
        controller.forward();
      } else {
        isTap = false;
        animation = tween.animate(
            CurvedAnimation(parent: controller, curve: widget.curve.flipped));
        controller.reverse();
      }
    }
  }
}

class _TapInheritedWidget extends InheritedWidget {
  const _TapInheritedWidget(
    this.t,
    this.isTap, {
    required super.child,
  });

  final double t;
  final bool isTap;

  static _TapInheritedWidget? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<_TapInheritedWidget>();
  }

  @override
  bool updateShouldNotify(_TapInheritedWidget oldWidget) {
    return true;
  }
}
