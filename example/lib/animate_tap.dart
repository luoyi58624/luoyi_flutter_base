import 'package:flutter/widgets.dart';

class AnimateTapBuilder extends StatefulWidget {
  const AnimateTapBuilder({
    super.key,
    required this.builder,
    this.duration = const Duration(milliseconds: 200),
    this.curve = Curves.linear,
  });

  final WidgetBuilder builder;
  final Duration duration;
  final Curve curve;

  static double t(BuildContext context) => _TapInheritedWidget.of(context).t;

  @override
  State<AnimateTapBuilder> createState() => _AnimateTapBuilderState();
}

class _AnimateTapBuilderState extends State<AnimateTapBuilder>
    with SingleTickerProviderStateMixin {
  bool flag = false;

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
  void didUpdateWidget(covariant AnimateTapBuilder oldWidget) {
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
      onTapDown: (e) {
        flag = true;
        animation = tween
            .animate(CurvedAnimation(parent: controller, curve: widget.curve));
        controller.forward();
      },
      onTapUp: (e) {
        flag = false;
        animation = tween.animate(
            CurvedAnimation(parent: controller, curve: widget.curve.flipped));
        controller.reverse();
      },
      onTapCancel: () {
        flag = false;
        animation = tween.animate(
            CurvedAnimation(parent: controller, curve: widget.curve.flipped));
        controller.reverse();
      },
      child: _TapInheritedWidget(
        animation.value,
        flag,
        child: Builder(builder: (context) {
          return widget.builder(context);
        }),
      ),
    );
  }
}

class _TapInheritedWidget extends InheritedWidget {
  const _TapInheritedWidget(
    this.t,
    this.flag, {
    required super.child,
  });

  final double t;
  final bool flag;

  static _TapInheritedWidget of(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<_TapInheritedWidget>()!;

  @override
  bool updateShouldNotify(_TapInheritedWidget oldWidget) {
    return true;
  }
}
