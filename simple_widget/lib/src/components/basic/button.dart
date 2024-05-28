part of '../../../../simple_widget.dart';

class Button extends HookWidget {
  const Button({
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
    var $color = color ?? const Color(0xfff3f4f6);
    return HoverBuilder(
      onlyCursor: true,
      disabled: onPressed == null,
      builder: (isHover) {
        return TapBuilder(
          onTap: onPressed,
          disabled: onPressed == null,
          builder: (isTap) {
            return Container(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              decoration: BoxDecoration(
                color: $color.onTap(context, isTap),
                borderRadius: BorderRadius.circular(context.appConfig.buttonRadius),
              ),
              child: DefaultTextStyle(
                style: TextStyle(
                  fontFamily: context.appConfig.fontFamily,
                  color: $color.isDark ? Colors.white : Colors.black,
                  fontWeight: FontWeight.w500,
                ),
                child: child,
              ),
            );
          },
        );
      },
    );
  }
}
