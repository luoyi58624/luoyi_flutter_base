part of '../../luoyi_flutter_base.dart';

class NoDefaultScrollbarWidget extends StatelessWidget {
  /// 没有默认滚动条小部件
  const NoDefaultScrollbarWidget({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return ScrollConfiguration(behavior: const _NoScrollBehavior(), child: child);
  }
}

class _NoScrollBehavior extends ScrollBehavior {
  const _NoScrollBehavior();

  @override
  Widget buildScrollbar(BuildContext context, Widget child, ScrollableDetails details) {
    switch (getPlatform(context)) {
      case TargetPlatform.linux:
      case TargetPlatform.macOS:
      case TargetPlatform.windows:
      case TargetPlatform.android:
      case TargetPlatform.fuchsia:
      case TargetPlatform.iOS:
        return child;
    }
  }
}

class DividerWidget extends StatelessWidget {
  /// 构建通用分割线Widget
  const DividerWidget({
    super.key,
    this.vertical = false,
    this.size,
    this.thickness = 0.5,
    this.indent = 0,
    this.color,
  });

  /// 是否为垂直分割线
  final bool vertical;

  /// 分割线实际占据的空间大小，默认跟随[thickness]
  final double? size;

  /// 分割线的线条粗细程度
  final double thickness;

  /// 分割线从什么位置开始绘制
  final double indent;

  /// 自定义分割线的颜色
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return vertical
        ? VerticalDivider(
            width: size ?? thickness,
            thickness: thickness,
            indent: indent,
            color: color ?? (context.isDark ? Colors.grey.shade700 : Colors.grey.shade300),
          )
        : Divider(
            height: size ?? thickness,
            thickness: thickness,
            indent: indent,
            color: color ?? (context.isDark ? Colors.grey.shade700 : Colors.grey.shade300),
          );
  }
}

/// 构建通用的列表分割线widget
IndexedWidgetBuilder buildSeparatorWidget(
  BuildContext context, {
  double indent = 0,
  Color? color,
}) {
  return (ctx, index) => DividerWidget(indent: indent, color: color);
}
