import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

import '../utils/platform/platform.dart';

class HoverBuilder extends StatefulWidget {
  /// hover构建器
  const HoverBuilder({
    super.key,
    required this.builder,
    this.cursor,
    this.disabled = false,
    this.onlyCursor = false,
    this.enableAnimate = false,
    this.duration = const Duration(milliseconds: 100),
    this.curve = Curves.linear,
    this.onEnter,
    this.onExit,
    this.onHover,
  });

  final WidgetBuilder builder;

  /// 鼠标悬停光标样式，默认点击
  final MouseCursor? cursor;

  /// 是否开启禁用样式，默认false
  final bool disabled;

  /// 是否仅更新显示的光标，但不触发状态
  final bool onlyCursor;

  /// 是否开启动画，默认 false，如果使用动画小部件，那么不需要使用 HoverBuilder 的动画。
  final bool enableAnimate;

  /// Hover 动画时间
  final Duration duration;

  /// 动画曲线
  final Curve curve;

  /// 鼠标进入事件
  final PointerEnterEventListener? onEnter;

  /// 鼠标离开事件
  final PointerExitEventListener? onExit;

  /// hover事件
  final PointerHoverEventListener? onHover;

  /// 动画插值
  static double t(BuildContext context) =>
      _HoverInheritedWidget.of(context)?.t ?? 0.0;

  /// 根据上下文获取最近的悬停状态
  static bool of(BuildContext context) =>
      _HoverInheritedWidget.of(context)?.isHover ?? false;

  /// 根据上下文获取最近的光标样式
  static MouseCursor? mouseCursor(BuildContext context) =>
      _HoverInheritedWidget.of(context)?.mouseCursor;

  @override
  State<HoverBuilder> createState() => _HoverBuilderState();
}

class _HoverBuilderState extends State<HoverBuilder>
    with SingleTickerProviderStateMixin {

  bool isHover = false;

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
  void didUpdateWidget(covariant HoverBuilder oldWidget) {
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
    // 仅限桌面端，移动端不存在hover
    if (PlatformUtil.isDesktop) {
      return MouseRegion(
        cursor: widget.disabled
            ? SystemMouseCursors.forbidden
            : (widget.cursor ?? MouseCursor.defer),
        onHover: widget.disabled ? null : widget.onHover,
        onEnter: widget.disabled ? null : _onEnter,
        onExit: widget.disabled ? null : _onExit,
        child: _HoverInheritedWidget(
          animation.value,
          isHover,
          widget.disabled ? SystemMouseCursors.forbidden : widget.cursor,
          child: Builder(builder: (context) {
            return widget.builder(context);
          }),
        ),
      );
    }
    return widget.builder(context);
  }

  void _onEnter(PointerEnterEvent event) {
    if (widget.onEnter != null) widget.onEnter!(event);
    if (!widget.onlyCursor && !isHover) {
      isHover = true;
      applyEnableAnimate();
      animation = tween
          .animate(CurvedAnimation(parent: controller, curve: widget.curve));
      controller.forward();
    }
  }

  void _onExit(PointerExitEvent event) {
    if (widget.onExit != null) widget.onExit!(event);
    if (!widget.onlyCursor && isHover) {
      isHover = false;
      applyEnableAnimate();
      animation = tween.animate(
          CurvedAnimation(parent: controller, curve: widget.curve.flipped));
      controller.reverse();
    }
  }

  void applyEnableAnimate() {
    if (widget.enableAnimate) {
      if (controller.duration == Duration.zero) {
        controller.duration = widget.duration;
      }
    } else {
      if (controller.duration != Duration.zero) {
        controller.duration = Duration.zero;
      }
    }
  }
}

class _HoverInheritedWidget extends InheritedWidget {
  const _HoverInheritedWidget(
    this.t,
    this.isHover,
    this.mouseCursor, {
    required super.child,
  });

  final double t;
  final bool isHover;
  final MouseCursor? mouseCursor;

  static _HoverInheritedWidget? of(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<_HoverInheritedWidget>();

  @override
  bool updateShouldNotify(_HoverInheritedWidget oldWidget) {
    return true;
  }
}
