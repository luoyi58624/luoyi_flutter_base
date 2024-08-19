import 'package:flutter/widgets.dart';
import 'package:super_sliver_list/super_sliver_list.dart';

abstract class _ListBase extends StatelessWidget {
  const _ListBase({
    super.key,
    required this.listType,
    required this.children,
    required this.listStyleType,
  });

  final _ListType listType;

  /// Li 列表子元素集合
  final List<Li> children;

  /// 列表样式类型
  final ListStyleType listStyleType;

  @override
  Widget build(BuildContext context) {
    return _ListInheritedWidget(
      listType,
      listStyleType,
      child: SuperListView.builder(
        itemCount: children.length,
        itemBuilder: (context, index) => children[index],
      ),
    );
  }
}

class Ul extends _ListBase {
  /// Html 无序列表
  const Ul({
    super.key,
    required super.children,
    super.listStyleType = ListStyleType.disc,
  }) : super(listType: _ListType.ul);
}

class Ol extends _ListBase {
  /// Html 有序列表
  const Ol({
    super.key,
    required super.children,
    super.listStyleType = ListStyleType.decimal,
  }) : super(listType: _ListType.ol);
}

class Li extends StatelessWidget {
  /// Html 列表子元素
  const Li({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final $data = _ListInheritedWidget.of(context);

    return child;
  }
}

enum _ListType { ul, ol }

enum ListStyleType {
  /// 无样式
  none,

  /// 实心圆，无序列表默认样式
  disc,

  /// 空心圆
  circle,

  /// 实心方块
  square,

  /// 阿拉伯数字，有序列表默认样式
  decimal,

  /// 小写罗马数字
  lowerRoman,

  /// 大写罗马数字
  upperRoman,

  /// 小写英文字母
  lowerAlpha,

  /// 大写英文字母
  upperAlpha,
}

class _ListInheritedWidget extends InheritedWidget {
  const _ListInheritedWidget(
    this.liType,
    this.listStyleType, {
    required super.child,
  });

  final _ListType liType;
  final ListStyleType listStyleType;

  static _ListInheritedWidget of(BuildContext context) {
    final _ListInheritedWidget? result =
        context.dependOnInheritedWidgetOfExactType<_ListInheritedWidget>();
    assert(result != null, 'No _ListInheritedWidget found in context');
    return result!;
  }

  @override
  bool updateShouldNotify(_ListInheritedWidget oldWidget) => true;
}
