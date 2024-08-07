import 'package:flutter/widgets.dart';

class ChildIndexData extends InheritedWidget {
  /// 一个功能小部件，让迭代的列表子元素确认自身所在的位置
  const ChildIndexData({
    super.key,
    required super.child,
    required this.index,
    this.start,
    this.end,
    this.length,
  });

  /// 当前索引
  final int index;

  /// 迭代元素起始索引，非必需，使用前请确认是否注入
  final int? start;

  /// 迭代元素结束索引，非必需，使用前请确认是否注入
  final int? end;

  /// 迭代元素总长度，非必需，使用前请确认是否注入
  final int? length;

  static ChildIndexData of(BuildContext context) {
    final ChildIndexData? result =
        context.dependOnInheritedWidgetOfExactType<ChildIndexData>();
    assert(result != null, 'No ChildIndexData found in context');
    return result!;
  }

  @override
  bool updateShouldNotify(ChildIndexData oldWidget) => true;
}
