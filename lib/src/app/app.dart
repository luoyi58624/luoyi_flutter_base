part of '../../luoyi_flutter_base.dart';

/// 顶级App组件，实现注入全局配置信息，构建[ThemeData]、[CupertinoThemeData]，构建[Overlay]遮罩层等功能
class AppWidget extends InheritedWidget {
  /// 注入[AppConfigData]全局配置数据
  AppWidget({
    super.key,
    required super.child,
    AppConfigData? data,
  }) {
    this.data = data ?? AppConfigData.config;
  }

  /// 全局配置数据
  late final AppConfigData data;

  /// 获取全局配置数据
  static AppConfigData of(BuildContext context) {
    final AppWidget? result = context.dependOnInheritedWidgetOfExactType<AppWidget>();
    assert(result != null, 'No App found in context');
    return result!.data;
  }

  /// 创建[Overlay]遮罩层，若没遮罩层，那么toast、loading将无法使用
  /// ```dart
  /// MaterialApp(
  ///   builder: AppWidget.builder(),
  /// );
  ///
  /// // 插入你自己自定义的builder方法
  /// MaterialApp(
  ///   builder: AppWidget.builder(
  ///     (context, child) => SizeBox(child: child!),
  ///   ),
  /// );
  /// ```
  static Widget Function(BuildContext, Widget?) builder([TransitionBuilder? builder]) =>
      (BuildContext context, Widget? child) {
        // 创建Overlay遮罩组件
        Widget overlayWidget = Overlay(
          initialEntries: [
            OverlayEntry(builder: (context) {
              _toast.init(context);
              // LoadingUtil2._init(context);
              return child!;
            })
          ],
        );

        return builder == null ? overlayWidget : builder(context, overlayWidget);
      };

  /// 根据注入的[AppConfigData]，构建 Material 主题数据，
  static ThemeData buildThemeData(BuildContext context, {Brightness brightness = Brightness.light}) {
    return _buildThemeData(context, brightness: brightness);
  }

  /// 根据注入的[AppConfigData]，构建 Cupertino 主题数据
  static CupertinoThemeData buildCupertinoThemeData(BuildContext context, {Brightness brightness = Brightness.light}) {
    return _buildCupertinoThemeData(context, brightness: brightness);
  }

  @override
  bool updateShouldNotify(AppWidget oldWidget) {
    return false;
  }
}

ThemeData _buildThemeData(
  BuildContext context, {
  Brightness brightness = Brightness.light,
}) {
  final appData = AppWidget.of(context);

  bool isDarkMode = brightness == Brightness.dark;
  final lightTheme = appData.theme;
  final darkTheme = appData.darkTheme;
  final appTheme = isDarkMode ? darkTheme : lightTheme;
  final fontFamily = appData.fontFamily;
  final isM3 = appData.useMaterial3;
  Color appbarColor = appTheme.headerColor ?? appTheme.primary;

  if (appData.translucenceStatusBar) {
    AsyncUtil.delayed(() {
      SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(statusBarColor: Color.fromRGBO(0, 0, 0, 200)));
    }, 200);
  } else {
    AsyncUtil.delayed(() {
      SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(statusBarColor: Color.fromRGBO(0, 0, 0, 0)));
    }, 200);
  }

  final themeData = ThemeData(
    useMaterial3: isM3,
// 应用颜色主题
    colorScheme: isM3
        ? ColorScheme.fromSeed(brightness: brightness, seedColor: appTheme.primary)
        : ColorScheme.fromSwatch(brightness: brightness, primarySwatch: appTheme.primary.toMaterialColor()),
// 设置全局默认文字主题
    textTheme: _textTheme(appTheme, appData),
// 扩展主题
    extensions: [appTheme],
// 是否禁用波纹
    splashFactory: appData.enableRipple ? InkRipple.splashFactory : noRipperFactory,
// 解决web上material按钮外边距为0问题，与移动端的效果保持一致
    materialTapTargetSize: MaterialTapTargetSize.padded,
// 标准显示密度
    visualDensity: VisualDensity.standard,
// 统一页面过渡动画
    pageTransitionsTheme: const PageTransitionsTheme(builders: {
      TargetPlatform.android: CupertinoPageTransitionsBuilder(),
      TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
      TargetPlatform.macOS: CupertinoPageTransitionsBuilder(),
    }),
    scaffoldBackgroundColor: appTheme.bgColor,
    iconTheme: IconThemeData(color: appTheme.iconColor),
    appBarTheme: AppBarTheme(
      centerTitle: appData.centerTitle,
      toolbarHeight: appData.appbarHeight,
      elevation: appData.appbarElevation,
      scrolledUnderElevation: appData.appbarScrollElevation,
      backgroundColor: appbarColor,
      titleTextStyle: TextStyle(
        fontFamily: fontFamily,
        fontSize: 18,
        fontWeight: FontUtil.medium,
        color: appbarColor.isDark ? darkTheme.textColor : lightTheme.textColor,
      ),
      iconTheme: IconThemeData(
        color: appbarColor.isDark ? darkTheme.iconColor : lightTheme.iconColor,
      ),
    ),
    tabBarTheme: TabBarTheme(
      labelStyle: TextStyle(
        fontFamily: fontFamily,
        fontWeight: FontUtil.medium,
        fontSize: 16,
        color: appbarColor.isDark ? darkTheme.textColor : lightTheme.textColor,
      ),
      unselectedLabelColor: appbarColor.isDark ? darkTheme.textColors[3] : lightTheme.textColor,
    ),
    cardTheme: CardTheme(
      color: appTheme.cardColor,
      // m3会将此颜色和color进行混合从而产生一个新的material颜色 (生成一个淡淡的Primary Color)，
      // 这里将其重置为透明，表示卡片用默认color展示
      surfaceTintColor: Colors.transparent,
      elevation: isDarkMode ? 4 : appData.cardElevation,
      margin: const EdgeInsets.all(8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(appData.radius),
      ),
    ),
    listTileTheme: ListTileThemeData(
      titleTextStyle: TextStyle(
        fontFamily: fontFamily,
        fontWeight: FontUtil.medium,
        color: appTheme.textColor,
        fontSize: 15,
      ),
      subtitleTextStyle: TextStyle(
        fontFamily: fontFamily,
        fontWeight: FontUtil.normal,
        color: appTheme.textColors[1],
        fontSize: 13,
      ),
      iconColor: appTheme.iconColor,
    ),
    inputDecorationTheme: InputDecorationTheme(
      border: const OutlineInputBorder(
        borderSide: BorderSide(color: Colors.grey),
      ),
      hintStyle: TextStyle(
        fontFamily: fontFamily,
        fontWeight: FontUtil.normal,
      ),
    ),
    expansionTileTheme: ExpansionTileThemeData(
      textColor: appTheme.primary,
      shape: Border.all(width: 0, style: BorderStyle.none),
      collapsedShape: Border.all(width: 0, style: BorderStyle.none),
    ),
    popupMenuTheme: PopupMenuThemeData(
      color: appTheme.cardColor,
      surfaceTintColor: Colors.transparent,
      elevation: isDarkMode ? 8 : 2,
      enableFeedback: true,
      textStyle: TextStyle(
        fontFamily: fontFamily,
        fontWeight: FontUtil.normal,
        color: appTheme.textColor,
        fontSize: 14,
      ),
    ),
    dialogTheme: DialogTheme(
      titleTextStyle: TextStyle(
        color: appTheme.textColor,
        fontSize: 18,
        fontWeight: FontUtil.medium,
      ),
      contentTextStyle: TextStyle(
        color: appTheme.textColors[2],
        fontSize: 15,
        fontWeight: FontUtil.normal,
      ),
      elevation: appData.cardElevation,
      backgroundColor: appTheme.cardColor,
      surfaceTintColor: Colors.transparent,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(appData.radius),
      ),
      actionsPadding: const EdgeInsets.all(8),
      insetPadding: EdgeInsets.zero,
    ),
    progressIndicatorTheme: ProgressIndicatorThemeData(
      refreshBackgroundColor: isDarkMode ? Colors.grey.shade700 : Colors.white,
      color: isDarkMode ? Colors.white : appTheme.primary,
    ),
    segmentedButtonTheme: const SegmentedButtonThemeData(
      style: ButtonStyle(
        shape: WidgetStatePropertyAll(
          StadiumBorder(side: BorderSide()),
        ),
        side: WidgetStatePropertyAll(BorderSide(color: Colors.grey)),
      ),
    ),
  );
  return themeData.copyWith();
}

CupertinoThemeData _buildCupertinoThemeData(
  BuildContext context, {
  Brightness brightness = Brightness.light,
}) {
  final appData = AppWidget.of(context);
  AppThemeData theme = brightness == Brightness.light ? appData.theme : appData.darkTheme;
  CupertinoThemeData themeData = CupertinoThemeData(brightness: brightness);
  String? fontFamily = appData.fontFamily ?? themeData.textTheme.textStyle.fontFamily;

  return themeData.copyWith(
    primaryColor: theme.primary,
    textTheme: CupertinoTextThemeData(
      textStyle: themeData.textTheme.textStyle.copyWith(
        fontFamily: fontFamily,
      ),
      tabLabelTextStyle: themeData.textTheme.tabLabelTextStyle.copyWith(
        fontSize: 12,
        fontFamily: fontFamily,
      ),
      navActionTextStyle: themeData.textTheme.navActionTextStyle.copyWith(
        color: theme.primary,
        fontFamily: fontFamily,
        fontWeight: FontUtil.medium,
        fontSize: 16,
      ),
      navTitleTextStyle: themeData.textTheme.navTitleTextStyle.copyWith(
        fontFamily: fontFamily,
        fontWeight: FontUtil.medium,
      ),
      navLargeTitleTextStyle: themeData.textTheme.navLargeTitleTextStyle.copyWith(
        fontFamily: fontFamily,
      ),
    ),
  );
}

TextTheme _textTheme(AppThemeData theme, AppConfigData config) {
  return TextTheme(
    displayLarge: TextStyle(
      fontWeight: FontUtil.bold,
      color: theme.textColor,
      fontFamily: config.fontFamily,
      fontFamilyFallback: config.fontFamilyFallback,
    ),
    displayMedium: TextStyle(
      fontWeight: FontUtil.medium,
      color: theme.textColor,
      fontFamily: config.fontFamily,
      fontFamilyFallback: config.fontFamilyFallback,
    ),
    displaySmall: TextStyle(
      fontWeight: FontUtil.medium,
      color: theme.textColor,
      fontFamily: config.fontFamily,
      fontFamilyFallback: config.fontFamilyFallback,
    ),
    headlineLarge: TextStyle(
      fontWeight: FontUtil.normal,
      color: theme.textColor,
      fontFamily: config.fontFamily,
      fontFamilyFallback: config.fontFamilyFallback,
    ),
    headlineMedium: TextStyle(
      fontWeight: FontUtil.normal,
      color: theme.textColor,
      fontFamily: config.fontFamily,
      fontFamilyFallback: config.fontFamilyFallback,
    ),
    headlineSmall: TextStyle(
      fontWeight: FontUtil.normal,
      color: theme.textColor,
      fontFamily: config.fontFamily,
      fontFamilyFallback: config.fontFamilyFallback,
    ),
    titleLarge: TextStyle(
      fontWeight: FontUtil.bold,
      color: theme.textColor,
      fontFamily: config.fontFamily,
      fontFamilyFallback: config.fontFamilyFallback,
    ),
    titleMedium: TextStyle(
      fontWeight: FontUtil.bold,
      color: theme.textColor,
      fontFamily: config.fontFamily,
      fontFamilyFallback: config.fontFamilyFallback,
    ),
    titleSmall: TextStyle(
      fontWeight: FontUtil.bold,
      color: theme.textColor,
      fontFamily: config.fontFamily,
      fontFamilyFallback: config.fontFamilyFallback,
    ),
    bodyLarge: TextStyle(
      fontWeight: FontUtil.normal,
      color: theme.textColor,
      fontFamily: config.fontFamily,
      fontFamilyFallback: config.fontFamilyFallback,
    ),
    bodyMedium: TextStyle(
      fontWeight: FontUtil.normal,
      color: theme.textColor,
      fontFamily: config.fontFamily,
      fontFamilyFallback: config.fontFamilyFallback,
    ),
    bodySmall: TextStyle(
      fontWeight: FontUtil.normal,
      color: theme.textColor,
      fontFamily: config.fontFamily,
      fontFamilyFallback: config.fontFamilyFallback,
    ),
    labelLarge: TextStyle(
      fontWeight: FontUtil.medium,
      color: theme.textColor,
      fontFamily: config.fontFamily,
      fontFamilyFallback: config.fontFamilyFallback,
    ),
    labelMedium: TextStyle(
      fontWeight: FontUtil.medium,
      color: theme.textColor,
      fontFamily: config.fontFamily,
      fontFamilyFallback: config.fontFamilyFallback,
    ),
    labelSmall: TextStyle(
      fontWeight: FontUtil.medium,
      color: theme.textColor,
      fontFamily: config.fontFamily,
      fontFamilyFallback: config.fontFamilyFallback,
    ),
  );
}
