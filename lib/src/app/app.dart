part of '../../luoyi_flutter_base.dart';

/// App全局配置
class AppWidget extends InheritedWidget {
  AppWidget({
    super.key,
    required super.child,
    AppConfigData? data,
  }) {
    this.data = data ?? AppConfigData.config;
  }

  /// 全局配置数据
  late final AppConfigData data;

  /// 如果没有注入[AppWidget]，将得到null
  static AppConfigData? maybeOf(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<AppWidget>()?.data;
  }

  /// 通过上下文拿到全局配置数据，建议通过[context.appConfig]直接获取
  static AppConfigData of(BuildContext context) {
    final AppConfigData? result = maybeOf(context);
    assert(result != null, 'No App found in context');
    return result!;
  }

  @override
  bool updateShouldNotify(AppWidget oldWidget) {
    return false;
  }

  /// 根据注入的[AppConfigData]，构建 Material 主题数据，如果[AppWidget]直接包裹[MaterialApp]，注意使用[Builder]转发[context]，
  /// 否则拿不到注入的[AppWidget]实例
  static ThemeData buildThemeData(
    BuildContext context, {
    Brightness brightness = Brightness.light,
  }) {
    final appData = AppWidget.maybeOf(context) ?? AppConfigData.config;

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
          fontWeight: FontUtil.medium,
          color: appTheme.textColors[1],
          fontSize: 13,
        ),
        iconColor: appTheme.iconColor,
      ),
      inputDecorationTheme: const InputDecorationTheme(
        border: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey),
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
          fontWeight: FontUtil.medium,
          color: appTheme.textColor,
          fontSize: 14,
        ),
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

  /// 根据注入的[AppConfigData]，构建 Cupertino 主题数据
  static CupertinoThemeData buildCupertinoThemeData(
    BuildContext context, {
    Brightness brightness = Brightness.light,
  }) {
    final appData = AppWidget.maybeOf(context) ?? AppConfigData.config;
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
}

TextTheme _textTheme(AppThemeData theme, AppConfigData config) {
  return TextTheme(
    displayLarge: TextStyle(
      fontWeight: FontUtil.normal,
      color: theme.textColor,
      fontFamily: config.fontFamily,
      fontFamilyFallback: config.fontFamilyFallback,
    ),
    displayMedium: TextStyle(
      fontWeight: FontUtil.normal,
      color: theme.textColor,
      fontFamily: config.fontFamily,
      fontFamilyFallback: config.fontFamilyFallback,
    ),
    displaySmall: TextStyle(
      fontWeight: FontUtil.normal,
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
