import 'package:flutter/widgets.dart';
import 'package:luoyi_flutter_base/luoyi_flutter_base.dart';

class AnimateHoverBuilder extends StatefulWidget {
  const AnimateHoverBuilder({
    super.key,
    required this.builder,
    this.duration = const Duration(milliseconds: 200),
    this.curve = Curves.linear,
  });

  final WidgetBuilder builder;
  final Duration duration;
  final Curve curve;

  static double t(BuildContext context) => _HoverInheritedWidget.of(context).t;

  @override
  State<AnimateHoverBuilder> createState() => _AnimateHoverBuilderState();
}

class _AnimateHoverBuilderState extends State<AnimateHoverBuilder>
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
  void didUpdateWidget(covariant AnimateHoverBuilder oldWidget) {
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
    return MouseRegion(
      onEnter: (e) {
        isHover = true;
        animation = tween
            .animate(CurvedAnimation(parent: controller, curve: widget.curve));
        controller.forward();
      },
      onExit: (e) {
        isHover = false;
        animation = tween.animate(
            CurvedAnimation(parent: controller, curve: widget.curve.flipped));
        controller.reverse();
      },
      child: _HoverInheritedWidget(
        animation.value,
        isHover,
        child: Builder(builder: (context) {
          return widget.builder(context);
        }),
      ),
    );
  }
}

class _HoverInheritedWidget extends InheritedWidget {
  const _HoverInheritedWidget(
    this.t,
    this.isHover, {
    required super.child,
  });

  final double t;
  final bool isHover;

  static _HoverInheritedWidget of(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<_HoverInheritedWidget>()!;

  @override
  bool updateShouldNotify(_HoverInheritedWidget oldWidget) {
    return true;
  }
}
