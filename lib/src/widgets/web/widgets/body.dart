import 'package:flutter/widgets.dart';
import 'package:luoyi_dart_base/luoyi_dart_base.dart';

import 'element.dart';

class Body extends BlockElement {
  /// Html Body 页面
  const Body(
    super.child, {
    super.key,
    this.backgroundColor = const Color(0xFFFFFFFF),
  });

  final Color backgroundColor;

  List<Widget> buildBodyChildrenWidget(List children) {
    List<Widget> childrenWidget = [];
    for (final child in children) {
      if (DartUtil.isBaseType(child)) {
        childrenWidget.add(Text('$child'));
      } else {
        childrenWidget.add(child);
      }
    }
    return childrenWidget;
  }

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: backgroundColor,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: isMultiNode
              ? buildBodyChildrenWidget(child)
              : [isBaseType ? Text('$child') : child],
        ),
      ),
    );
  }
}
