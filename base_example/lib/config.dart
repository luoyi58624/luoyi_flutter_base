import 'package:luoyi_flutter_base/luoyi_flutter_base.dart';

class MobileAppConfigData extends FlutterConfigData {
  int borderRadius;

  MobileAppConfigData({
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
    List<String>? fontFamilyFallback,
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
      radius: radius ?? this.radius,
      centerTitle: centerTitle ?? this.centerTitle,
      enableRipple: enableRipple ?? this.enableRipple,
      hoverScale: hoverScale ?? this.hoverScale,
      tapScale: tapScale ?? this.tapScale,
      borderRadius: borderRadius ?? this.borderRadius,
    );
  }
}
