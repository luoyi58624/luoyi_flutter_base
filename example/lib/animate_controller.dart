import 'package:flutter/widgets.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_obs/flutter_obs.dart';

AnimationController useMyAnimateController({
  TickerProvider? vsync,
}) {
  final $vsync = vsync ?? useSingleTickerProvider();
  return use(
    _ObsHook(
      $vsync,
    ),
  );
}

class _ObsHook extends Hook<AnimationController> {
  const _ObsHook(this.vsync);

  final TickerProvider vsync;

  @override
  _ObsHookState createState() => _ObsHookState();
}

class _ObsHookState extends HookState<AnimationController, _ObsHook> {
  late final _animationController = AnimationController(
    vsync: hook.vsync,
    animationBehavior: AnimationBehavior.normal,
  );

  @override
  void didUpdateHook(_ObsHook oldHook) {
    super.didUpdateHook(oldHook);
    if (hook.vsync != oldHook.vsync) {
      _animationController.resync(hook.vsync);
    }
  }

  @override
  AnimationController build(BuildContext context) => _animationController;

  @override
  void dispose() {
    _animationController.dispose();
  }
}
