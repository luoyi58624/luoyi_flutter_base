import 'package:flutter/widgets.dart';
import 'package:luoyi_dart_base/luoyi_dart_base.dart';
import 'package:luoyi_flutter_base/src/widgets/html/style/style.dart';

abstract class HtmlElement extends StatelessWidget {
  const HtmlElement({super.key});
}

class Div extends StatelessWidget {
  const Div(this.child, {super.key, this.style});

  final dynamic child;
  final Style? style;

  EdgeInsetsGeometry? get margin {
    if (style!.margin == null || style!.margin!.isEmpty) return null;
    final $ = style!.margin!;
    return $.length == 1
        ? EdgeInsets.all($[0])
        : $.length == 2
            ? EdgeInsets.symmetric(vertical: $[0], horizontal: $[1])
            : EdgeInsets.fromLTRB($[3], $[0], $[1], $[2]);
  }

  EdgeInsetsGeometry? get padding {
    if (style!.padding == null || style!.padding!.isEmpty) return null;
    final $ = style!.padding!;
    return $.length == 1
        ? EdgeInsets.all($[0])
        : $.length == 2
            ? EdgeInsets.symmetric(vertical: $[0], horizontal: $[1])
            : EdgeInsets.fromLTRB($[3], $[0], $[1], $[2]);
  }

  @override
  Widget build(BuildContext context) {
    int start = DateTime.now().microsecondsSinceEpoch;
    Widget result = Container(
      width: style?.width,
      height: style?.height,
      margin: margin,
      padding: padding,
      color: style?.backgroundColor,
      alignment: style?.alignment,
      child: DefaultTextStyle.merge(
        style: TextStyle(color: style?.color),
        child: child is Widget ? child : Text('$child'),
      ),
    );

    i(DateTime.now().microsecondsSinceEpoch - start, '渲染div耗时(微秒)');
    return result;
  }
}
