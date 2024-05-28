part of '../../luoyi_flutter_base.dart';

class HoverBuilder extends StatefulWidget {
  /// 鼠标悬停构造器，移动端不会渲染
  const HoverBuilder({
    super.key,
    required this.builder,
    this.cursor = SystemMouseCursors.click,
    this.disabled = false,
    this.onlyCursor = false,
  });

  final Widget Function(bool isHover) builder;

  /// 鼠标悬停光标样式，默认点击
  final MouseCursor cursor;

  /// 是否开启禁用样式，默认false
  final bool disabled;

  /// 是否仅更新显示的光标，但不触发状态，默认false
  final bool onlyCursor;

  @override
  State<HoverBuilder> createState() => _HoverBuilderState();
}

class _HoverBuilderState extends State<HoverBuilder> {
  bool isHover = false;

  @override
  Widget build(BuildContext context) {
    return GetPlatform.isDesktop
        ? MouseRegion(
            onEnter: (widget.onlyCursor || widget.disabled) ? null : (event) => update(true),
            onExit: (widget.onlyCursor || widget.disabled) ? null : (event) => update(false),
            cursor: widget.disabled ? SystemMouseCursors.forbidden : widget.cursor,
            child: widget.builder(isHover),
          )
        : widget.builder(isHover);
  }

  void update(bool enabled) {
    setState(() {
      isHover = enabled;
    });
  }
}
