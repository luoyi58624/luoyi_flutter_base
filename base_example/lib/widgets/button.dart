import 'package:flutter/material.dart';
import 'package:luoyi_flutter_base/luoyi_flutter_base.dart';

class ButtonWidget extends StatelessWidget {
  const ButtonWidget({
    super.key,
    required this.onPressed,
    required this.child,
    this.color,
  });

  final GestureTapCallback? onPressed;
  final Widget child;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    var $color = color ?? const Color(0xffe5e7eb);
    return TapBuilder(
      onTap: onPressed,
      builder: (isTap) {
        return Container(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          decoration: BoxDecoration(
            color: $color.onTap(context, isTap),
            borderRadius: BorderRadius.circular(context.configData.radius),
          ),
          child: DefaultTextStyle(
            style: TextStyle(
              fontFamily: context.configData.fontFamily,
              color: $color.isDark ? Colors.white : Colors.black,
              fontWeight: FontUtil.medium,
            ),
            child: child,
          ),
        );
      },
    );
  }
}
