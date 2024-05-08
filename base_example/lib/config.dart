import 'package:luoyi_flutter_base/luoyi_flutter_base.dart';

class MobileAppConfigData extends FlutterConfigData {
  int borderRadius;

  MobileAppConfigData({
    super.fontFamily,
    super.useMaterial3,
    super.radius,
    super.centerTitle,
    super.enableRipple,
    super.hoverScale,
    super.tapScale,
    this.borderRadius = 4,
  });

  @override
  MobileAppConfigData copyWith({
    String? fontFamily,
    bool? useMaterial3,
    double? radius,
    bool? centerTitle,
    bool? enableRipple,
    bool? translucenceStatusBar,
    int? hoverScale,
    int? tapScale,
    int? borderRadius,
  }) {
    return MobileAppConfigData(
      fontFamily: fontFamily ?? this.fontFamily,
      useMaterial3: useMaterial3 ?? this.useMaterial3,
      radius: radius ?? this.radius,
      centerTitle: centerTitle ?? this.centerTitle,
      enableRipple: enableRipple ?? this.enableRipple,
      hoverScale: hoverScale ?? this.hoverScale,
      tapScale: tapScale ?? this.tapScale,
      borderRadius: borderRadius ?? this.borderRadius,
    );
  }
}
