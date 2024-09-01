import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

import '../utils/platform/platform.dart';

/// 事件动画配置类
class EventAnimateConfig extends InheritedWidget {
  const EventAnimateConfig({
    super.key,
    required super.child,
    this.enableAnimate = false,
    this.hoverDuration = Duration.zero,
    this.tapDuration = Duration.zero,
    this.hoverCurve = Curves.linear,
    this.tapCurve = Curves.linear,
    this.delayTap = 100,
  });

  /// 使用启用动画
  final bool enableAnimate;

  /// 默认的 Hover 动画时间
  final Duration hoverDuration;

  /// 默认的 Tap 动画时间
  final Duration tapDuration;

  /// 默认的 Hover 动画曲线
  final Curve hoverCurve;

  /// 默认的 Tap 动画曲线
  final Curve tapCurve;

  /// 延迟释放点击事件，单位：毫秒；
  /// 设置一定的延迟可以让点击效果更加明显
  final int delayTap;

  static EventAnimateConfig of(BuildContext context) {
    final EventAnimateConfig? result =
        context.dependOnInheritedWidgetOfExactType<EventAnimateConfig>();
    assert(result != null, 'No EventAnimateConfig found in context');
    return result!;
  }

  @override
  bool updateShouldNotify(EventAnimateConfig oldWidget) {
    return true;
  }
}

class EventAnimateBuilder extends StatefulWidget {
  const EventAnimateBuilder({
    super.key,
    required this.builder,
    this.cursor,
    this.disabled = false,
    this.onlyCursor = false,
    this.enableAnimate,
    this.hoverDuration,
    this.tapDuration,
    this.hoverCurve,
    this.tapCurve,
    this.delayTap,
    this.onTap,
    this.onTapDown,
    this.onTapUp,
    this.onTapCancel,
    this.onEnter,
    this.onExit,
    this.onHover,
  });

  final Widget Function(
    BuildContext context,
    // EventAnimateData eventData,
  ) builder;

  /// 鼠标悬停光标样式，默认点击
  final MouseCursor? cursor;

  /// 是否开启禁用样式，默认false
  final bool disabled;

  /// 是否仅更新显示的光标，不触发悬停更新状态，如果内部没有依赖悬停状态的逻辑，
  /// 将此属性设置为 true 可以防止不必要的重建
  final bool onlyCursor;

  /// 使用启用动画
  final bool? enableAnimate;

  /// Hover 动画时间
  final Duration? hoverDuration;

  /// Tap 动画时间
  final Duration? tapDuration;

  /// Hover 动画曲线
  final Curve? hoverCurve;

  /// Tap 动画曲线
  final Curve? tapCurve;

  /// 延迟释放点击事件，单位：毫秒；
  /// 设置一定的延迟可以让点击效果更加明显
  final int? delayTap;

  /// 点击事件
  final GestureTapCallback? onTap;

  /// 按下事件
  final GestureTapDownCallback? onTapDown;

  /// 抬起事件
  final GestureTapUpCallback? onTapUp;

  /// 按下取消事件
  final GestureTapCancelCallback? onTapCancel;

  /// 鼠标进入事件
  final PointerEnterEventListener? onEnter;

  /// 鼠标离开事件
  final PointerExitEventListener? onExit;

  /// hover事件
  final PointerHoverEventListener? onHover;

  @override
  State<EventAnimateBuilder> createState() => _EventAnimateBuilderState();
}

class _EventAnimateBuilderState extends State<EventAnimateBuilder>
    with SingleTickerProviderStateMixin {
  bool isTap = false;
  bool isHover = false;

  late int delayTap;
  late bool enableAnimate;
  late AnimationController controller = AnimationController(vsync: this);
  final Tween tween = Tween(begin: 0.0, end: 1.0);
  late Animation animation;
  Duration? hoverDuration;
  Duration? tapDuration;
  Curve? hoverCurve;
  Curve? tapCurve;

  @override
  void initState() {
    super.initState();
    controller.addListener(() {
      setState(() {});
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  void didUpdateWidget(covariant EventAnimateBuilder oldWidget) {
    super.didUpdateWidget(oldWidget);
    final $data = EventAnimateConfig.of(context);
    if (widget.delayTap != oldWidget.delayTap) {
      if (widget.delayTap != null) {
        delayTap = widget.delayTap!;
      } else {
        delayTap = $data.delayTap;
      }
    }

    if (widget.enableAnimate != oldWidget.enableAnimate) {
      if (widget.enableAnimate != null) {
        enableAnimate = widget.enableAnimate!;
      } else {
        enableAnimate = $data.enableAnimate;
      }
    }

    if (widget.hoverDuration != oldWidget.hoverDuration) {
      if (widget.hoverDuration != null) {
        hoverDuration = widget.hoverDuration;
      } else {
        hoverDuration = $data.hoverDuration;
      }
    }

    if (widget.tapDuration != oldWidget.tapDuration) {
      if (widget.tapDuration != null) {
        tapDuration = widget.tapDuration;
      } else {
        tapDuration = $data.tapDuration;
      }
    }

    if (widget.hoverCurve != oldWidget.hoverCurve) {
      if (widget.hoverCurve != null) {
        hoverCurve = widget.hoverCurve;
      } else {
        hoverCurve = $data.hoverCurve;
      }
      // animation = tween.animate(CurvedAnimation(
      //   parent: controller,
      //   curve: widget.curve,
      // ));
    }

    if (widget.tapCurve != oldWidget.tapCurve) {
      if (widget.tapCurve != null) {
        tapCurve = widget.tapCurve;
      } else {
        tapCurve = $data.tapCurve;
      }
    }
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  void _onEnter(PointerEnterEvent event) {
    if (widget.onEnter != null) widget.onEnter!(event);
    if (!widget.onlyCursor && !isHover) {
      isHover = true;
      _setHoverDuration();
      animation = tween.animate(CurvedAnimation(
        parent: controller,
        curve: hoverCurve!,
      ));
      controller.forward();
    }
  }

  void _onExit(PointerExitEvent event) {
    if (widget.onExit != null) widget.onExit!(event);
    if (!widget.onlyCursor && isHover) {
      isHover = false;
      _setHoverDuration();
      animation = tween.animate(CurvedAnimation(
        parent: controller,
        curve: hoverCurve!.flipped,
      ));
      controller.reverse();
    }
  }

  // void _onTapDown(TapDownDetails event) {
  //   _time = currentMilliseconds;
  //   if (_timer != null) {
  //     _timer!.cancel();
  //     _timer = null;
  //     update(false);
  //     (() => update(true)).delay(16);
  //   } else {
  //     update(true);
  //   }
  // }

  void _setHoverDuration() {
    if (enableAnimate) {
      if (controller.duration == Duration.zero) {
        controller.duration = hoverDuration;
      }
    } else {
      if (controller.duration != Duration.zero) {
        controller.duration = Duration.zero;
      }
    }
  }

  T buildAnimate<T>(
    T value, {
    T? tapValue,
    T? hoverValue,
    Tween? tween,
  }) {
    if (hoverValue != null) {}
    return value;
  }

  @override
  Widget build(BuildContext context) {
    final $data = EventAnimateConfig.of(context);
    delayTap = widget.delayTap ?? $data.delayTap;
    enableAnimate = widget.enableAnimate ?? $data.enableAnimate;
    if (enableAnimate) {
      hoverDuration = widget.hoverDuration ?? $data.hoverDuration;
      tapDuration = widget.tapDuration ?? $data.tapDuration;
      hoverCurve = widget.hoverCurve ?? $data.hoverCurve;
      tapCurve = widget.tapCurve ?? $data.tapCurve;
    }

    Widget result = GestureDetector(
      onTap: widget.disabled ? null : widget.onTap,
      child: Builder(builder: (context) {
        return widget.builder(context);
      }),
    );
    // hover仅限桌面端，移动端不存在hover
    if (PlatformUtil.isDesktop) {
      result = MouseRegion(
        cursor: widget.disabled
            ? SystemMouseCursors.forbidden
            : (widget.cursor ?? MouseCursor.defer),
        onHover: widget.disabled ? null : widget.onHover,
        onEnter: widget.disabled ? null : _onEnter,
        onExit: widget.disabled ? null : _onExit,
        child: result,
      );
    }
    return result;
  }
}

class EventAnimateData {
  /// 动画插值
  final double t;

  /// 当前处于点击状态
  final bool isTap;

  /// 当前处于悬停状态
  final bool isHover;

  /// 悬停的光标
  final MouseCursor? mouseCursor;

  EventAnimateData({
    required this.t,
    required this.isTap,
    required this.isHover,
    required this.mouseCursor,
  });
}
