part of '../../luoyi_flutter_base.dart';

class TapBuilder extends StatefulWidget {
  /// 按下事件构造器
  const TapBuilder({
    super.key,
    required this.builder,
    this.onTap,
    this.delay = 100,
    this.disabled = false,
  }) : assert(delay >= 0);

  final Widget Function(bool isTap) builder;

  final GestureTapCallback? onTap;

  /// 延迟多少毫秒更新点击状态，如果为0将不会更新点击状态
  final int delay;

  /// 是否禁用，默认false
  final bool disabled;

  @override
  State<TapBuilder> createState() => _TapBuilderState();
}

class _TapBuilderState extends State<TapBuilder> {
  bool isTap = false;
  Timer? _timer;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.disabled ? null : widget.onTap,
      onTapDown: (widget.delay == 0 || widget.disabled)
          ? null
          : (e) {
              if (_timer != null) {
                _timer!.cancel();
                _timer = null;
                update(false);
                DartUtil.delay(() => update(true), 16);
              } else {
                update(true);
              }
            },
      onTapUp: (widget.delay == 0 || widget.disabled)
          ? null
          : (e) {
              _timer = DartUtil.delay(() {
                update(false);
                _timer = null;
              }, widget.delay);
            },
      onTapCancel: (widget.delay == 0 || widget.disabled)
          ? null
          : () {
              _timer = DartUtil.delay(() {
                update(false);
                _timer = null;
              }, widget.delay);
            },
      child: widget.builder(isTap),
    );
  }

  void update(bool enabled) {
    if (isTap != enabled) setState(() => isTap = enabled);
  }
}
