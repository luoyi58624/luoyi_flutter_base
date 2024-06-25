import 'package:flutter/widgets.dart';
import 'package:luoyi_dart_base/luoyi_dart_base.dart';

import '../style/style.dart';

/// 用于划分块级、行内元素，对于连续的行内元素，会进行合并操作
class _NodeTypeSegmentRecord {
  final bool isInlineNode;
  (int, int) section;

  _NodeTypeSegmentRecord(this.isInlineNode, this.section);

  @override
  String toString() {
    return '_NodeTypeSegmentRecord{isInlineNode: $isInlineNode, section: $section}';
  }
}

abstract class WebElement extends StatelessWidget {
  const WebElement(this.child, {super.key, this.style});

  /// web support any type child node
  final dynamic child;
  final Style? style;

  /// Check whether the current [child] node is of a basic type
  bool get isBaseType => DartUtil.isBaseType(child);

  bool get isInlineElement => isBaseType || child is InlineElement;

  bool get isBlockElement => child is BlockElement;

  /// Check whether the current [child] node is of a multi node
  bool get isMultiNode => child is List;

  /// build web element child node
  // List<Widget> buildNode() {
  //   if (isMultiNode) return buildMultiNode(child);
  //   if (isBaseType) return [Text('$child')];
  // }

  /// build inline node
  Widget? buildInlineNode(List children) {
    Widget? node;
    List<TextSpan> inlineNodes = [];
    for (final child in children) {
      if (DartUtil.isBaseType(child)) {
        inlineNodes.add(TextSpan(text: '$child'));
      } else if (child is WebElement) {
        if (child.isMultiNode) {
          child.buildMultiNode(child.child);
        } else if (child.isInlineElement) {}
      } else if (child is Widget) {}
    }
    if (DartUtil.isBaseType(child)) {
      node = Text('$child');
    } else if (child is Text) {
      node = child;
    }
    if (node == null) return null;
    if (style == null) return node;
    if (style!.color != null || style!.fontSize != null) {
      return DefaultTextStyle.merge(
        style: TextStyle(
          color: style!.color,
          fontSize: style!.fontSize,
        ),
        child: node,
      );
    }
    return node;
  }

  /// Builds multiple child nodes under block-level elements
  List<Widget> buildMultiNode(List children) {
    List<Widget> nodes = [];
    List<_NodeTypeSegmentRecord> nodeTypeSegmentRecords = [];
    for (int i = 0; i < children.length; i++) {
      var child = children[i];

      // set continue inline node element
      if (DartUtil.isBaseType(child)) {
        if (nodeTypeSegmentRecords.isEmpty) {
          nodeTypeSegmentRecords.add(_NodeTypeSegmentRecord(true, (i, i)));
        } else {
          if (nodeTypeSegmentRecords.last.isInlineNode) {
            nodeTypeSegmentRecords[nodeTypeSegmentRecords.length - 1] =
                _NodeTypeSegmentRecord(true, (
              nodeTypeSegmentRecords.last.section.$1,
              nodeTypeSegmentRecords.last.section.$2 + 1
            ));
          } else {
            nodeTypeSegmentRecords.add(_NodeTypeSegmentRecord(true, (i, i)));
          }
        }
      } else {
        nodeTypeSegmentRecords.add(_NodeTypeSegmentRecord(false, (i, i)));
      }
    }

    for (var nodeTypeRecord in nodeTypeSegmentRecords) {
      Widget? node;
      if (nodeTypeRecord.isInlineNode) {
        node = buildInlineNode(children.sublist(
          nodeTypeRecord.section.$1,
          nodeTypeRecord.section.$2,
        ));
      } else {}
      if (node != null) nodes.add(node);
    }
    for (final child in children) {
      if (DartUtil.isBaseType(child)) {
        nodes.add(Text('$child'));
      } else {
        nodes.add(child);
      }
    }
    return nodes;
  }
}

/// Block element, it has width and height, multiple block widget wrap lines when they are together
abstract class BlockElement extends WebElement {
  const BlockElement(super.child, {super.key, super.style});
}

/// 行内元素
abstract class InlineElement extends WebElement {
  const InlineElement(super.child, {super.key, super.style});
}

class Div2 extends BlockElement {
  const Div2(super.child, {super.key, super.style});

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
