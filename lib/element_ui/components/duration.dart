import 'dart:async';
import 'dart:math';

import 'package:flutter/widgets.dart';
import 'package:luoyi_dart_base/luoyi_dart_base.dart';
import 'package:luoyi_flutter_base/src/extensions/context.dart';

import '../../src/commons/global.dart';

/// 应用全局主题过渡持续时间
class ElThemeDuration extends InheritedWidget {
  const ElThemeDuration({
    super.key,
    this.duration,
    required super.child,
  });

  final Duration? duration;

  static Duration? maybeOf(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<ElThemeDuration>()?.duration;

  @override
  bool updateShouldNotify(ElThemeDuration oldWidget) => true;
}

class ElDurationBuilder extends StatefulWidget {
  const ElDurationBuilder({
    super.key,
    required this.duration,
    required this.builder,
  });

  final Duration duration;
  final WidgetBuilder builder;

  static Duration of(BuildContext context) =>
      _ElDurationBuilderInheritedWidget.maybeOf(context) ??
      GlobalConfig.themeDuration;

  @override
  State<ElDurationBuilder> createState() => _ElDurationBuilderState();
}

class _ElDurationBuilderState extends State<ElDurationBuilder> {
  Duration? _duration;

  Duration get duration => _duration!;

  set duration(Duration v) {
    if (_timer != null) {
      _timer!.cancel();
      _timer = null;
    }
    _duration = v;
  }

  bool flag = true;
  Timer? _timer;

  void updateDuration(int ms) {
    _timer = () {
      _timer = null;
      setState(() {
        flag = false;
        duration = GlobalConfig.themeDuration;
      });
    }.delay(ms);
  }

  @override
  Widget build(BuildContext context) {
    if (flag) {
      final $1 = widget.duration.inMilliseconds;
      final $2 = GlobalConfig.themeDuration.inMilliseconds;
      if ($1 == $2) {
        duration = widget.duration;
      } else {
        if (context.isHover || context.isTap) {
          duration = widget.duration;
        } else {
          duration = widget.duration;
          updateDuration(max($1, $2));
        }
      }
    } else {
      flag = true;
    }

    return _ElDurationBuilderInheritedWidget(
      duration,
      child: Builder(builder: (context) {
        return widget.builder(context);
      }),
    );
  }
}

class _ElDurationBuilderInheritedWidget extends InheritedWidget {
  const _ElDurationBuilderInheritedWidget(
    this.duration, {
    required super.child,
  });

  final Duration duration;

  static Duration? maybeOf(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<_ElDurationBuilderInheritedWidget>()
        ?.duration;
  }

  @override
  bool updateShouldNotify(_ElDurationBuilderInheritedWidget oldWidget) => true;
}
