part of '../../luoyi_flutter_base.dart';

extension AppDataContextExtension on BuildContext {
  /// 当前主题数据
  AppThemeData get appTheme => Theme.of(this).extension<AppThemeData>() ?? (isDarkMode ? AppThemeData.darkTheme : AppThemeData.theme);

  /// 全局配置数据
  AppConfigData get appConfig => AppData.maybeOf(this)?.config ?? AppConfigData.config;

  bool get isM3 => Theme.of(this).useMaterial3;

  /// Appbar高度
  double get appbarHeight => isM3 ? appConfig.m3Config.appbar.height : appConfig.m2Config.appbar.height;

  /// 导航栏默认颜色
  Color get appbarColor =>
      isM3 ? appTheme.headerColor : (appConfig.m2Config.appbar.usePrimaryColor ? appTheme.primary : appTheme.headerColor);

  /// 标题1 - 28px
  TextStyle get h1 => TextStyle(
        fontFamily: appConfig.fontFamily,
        fontWeight: FontUtil.bold,
        fontSize: appConfig.textSizeConfig.h1,
        color: appTheme.textColor,
      );

  /// 标题2 - 24px
  TextStyle get h2 => TextStyle(
        fontFamily: appConfig.fontFamily,
        fontWeight: FontUtil.bold,
        fontSize: appConfig.textSizeConfig.h2,
        color: appTheme.textColor,
      );

  /// 标题3 - 20px
  TextStyle get h3 => TextStyle(
        fontFamily: appConfig.fontFamily,
        fontWeight: FontUtil.bold,
        fontSize: appConfig.textSizeConfig.h3,
        color: appTheme.textColor,
      );

  /// 标题4 - 18px
  TextStyle get h4 => TextStyle(
        fontFamily: appConfig.fontFamily,
        fontWeight: FontUtil.bold,
        fontSize: appConfig.textSizeConfig.h4,
        color: appTheme.textColor,
      );

  /// 标题5 - 16px
  TextStyle get h5 => TextStyle(
        fontFamily: appConfig.fontFamily,
        fontWeight: FontUtil.bold,
        fontSize: appConfig.textSizeConfig.h5,
        color: appTheme.textColor,
      );

  /// 标题6 - 14px
  TextStyle get h6 => TextStyle(
        fontFamily: appConfig.fontFamily,
        fontWeight: FontUtil.bold,
        fontSize: appConfig.textSizeConfig.h6,
        color: appTheme.textColor,
      );
}

extension FlutterThemeDataExtension on ThemeData {
  /// 应用[AppData]的主题数据和配置信息
  ThemeData applyAppData(BuildContext context) {
    AppData? appData = AppData.maybeOf(context);

    bool isDarkMode = brightness == Brightness.dark;
    final lightTheme = appData?.theme ?? AppThemeData.theme;
    final darkTheme = appData?.darkTheme ?? AppThemeData.darkTheme;
    final appTheme = isDarkMode ? darkTheme : lightTheme;
    AppConfigData appConfig = appData?.config ?? AppConfigData.config;
    String? fontFamily = appConfig.fontFamily ?? textTheme.displayLarge?.fontFamily;

    bool isM3 = appConfig.useMaterial3;

    Color appbarColor = isDarkMode
        ? appTheme.headerColor
        : isM3
            ? appTheme.headerColor
            : (appConfig.m2Config.appbar.usePrimaryColor ? appTheme.primary : appTheme.headerColor);

    if (isM3) {
      AsyncUtil.delayed(() {
        SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(statusBarColor: Color.fromRGBO(0, 0, 0, 0)));
      }, 200);
    } else {
      if (appConfig.m2Config.translucenceStatusBar) {
        AsyncUtil.delayed(() {
          SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(statusBarColor: Color.fromRGBO(0, 0, 0, 200)));
        }, 200);
      } else {
        AsyncUtil.delayed(() {
          SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(statusBarColor: Color.fromRGBO(0, 0, 0, 0)));
        }, 200);
      }
    }

    return copyWith(
      useMaterial3: isM3,
      // 应用颜色主题
      colorScheme: isM3
          ? ColorScheme.fromSeed(brightness: brightness, seedColor: appTheme.primary)
          : ColorScheme.fromSwatch(brightness: brightness, primarySwatch: appTheme.primary.toMaterialColor()),
      textTheme: _textTheme(appTheme, appConfig),
      // 扩展主题
      extensions: [appTheme],
      // 是否禁用波纹
      splashFactory: appConfig.enableRipple ? InkRipple.splashFactory : noRipperFactory,
      // 解决web上material按钮外边距为0问题，与移动端的效果保持一致
      materialTapTargetSize: MaterialTapTargetSize.padded,
      // 标准显示密度
      visualDensity: VisualDensity.standard,
      canvasColor: appTheme.bgColors[0],
      // 统一页面过渡动画
      pageTransitionsTheme: const PageTransitionsTheme(builders: {
        TargetPlatform.android: CupertinoPageTransitionsBuilder(),
        TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
        TargetPlatform.macOS: CupertinoPageTransitionsBuilder(),
      }),
      // 设置页面背景色
      scaffoldBackgroundColor: appTheme.bgColor,
      appBarTheme: appBarTheme.copyWith(
        centerTitle: appConfig.centerTitle,
        toolbarHeight: isM3 ? appConfig.m3Config.appbar.height : appConfig.m2Config.appbar.height,
        elevation: isM3 ? 0 : appConfig.m2Config.appbar.elevation,
        scrolledUnderElevation: isM3 ? (appConfig.m3Config.appbar.scrollShade ? 4 : 0) : appConfig.m2Config.appbar.scrollElevation,
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
      // 设置底部导航栏
      bottomNavigationBarTheme: bottomNavigationBarTheme.copyWith(
        elevation: 0,
        backgroundColor: appTheme.bgColors[0],
        selectedItemColor: appTheme.primary,
        unselectedLabelStyle: TextStyle(fontFamily: fontFamily, fontWeight: FontWeight.w500, fontSize: 12),
        selectedLabelStyle: TextStyle(fontFamily: fontFamily, fontWeight: FontWeight.w500, fontSize: 12),
        unselectedIconTheme: IconThemeData(size: 26, color: appTheme.iconColors[3]),
        selectedIconTheme: IconThemeData(size: 26, color: appTheme.primary),
      ),
      iconTheme: IconThemeData(color: appTheme.iconColor),
      cardTheme: CardTheme(
        color: appTheme.bgColors[0],
        // m3会将此颜色和color进行混合从而产生一个新的material颜色 (生成一个淡淡的Primary Color)，
        // 这里将其重置为透明，表示卡片用默认color展示
        surfaceTintColor: Colors.transparent,
        elevation: isDarkMode ? 4 : (isM3 ? appConfig.m3Config.cardElevation : appConfig.m2Config.cardElevation),
        margin: const EdgeInsets.all(8),
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
      popupMenuTheme: popupMenuTheme.copyWith(
        color: appTheme.bgColors[1],
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
      listTileTheme: listTileTheme.copyWith(
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
      progressIndicatorTheme: ProgressIndicatorThemeData(
        refreshBackgroundColor: isDarkMode ? Colors.grey.shade700 : Colors.white,
        color: isDarkMode ? Colors.white : appTheme.primary,
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
    );
  }
}

extension FlutterCupertinoThemeDataExtension on CupertinoThemeData {
  CupertinoThemeData applyAppData(BuildContext context) {
    AppData? appData = AppData.maybeOf(context);

    AppThemeData theme =
        brightness == Brightness.light ? (appData?.theme ?? AppThemeData.theme) : (appData?.darkTheme ?? AppThemeData.darkTheme);

    AppConfigData config = appData?.config ?? AppConfigData.config;
    String? fontFamily = config.fontFamily ?? textTheme.textStyle.fontFamily;

    return copyWith(
      primaryColor: theme.primary,
      textTheme: CupertinoTextThemeData(
        textStyle: textTheme.textStyle.copyWith(
          fontFamily: fontFamily,
        ),
        tabLabelTextStyle: textTheme.tabLabelTextStyle.copyWith(
          fontSize: 12,
          fontFamily: fontFamily,
        ),
        navActionTextStyle: textTheme.navActionTextStyle.copyWith(
          color: theme.primary,
          fontFamily: fontFamily,
          fontWeight: FontUtil.medium,
          fontSize: 16,
        ),
        navTitleTextStyle: textTheme.navTitleTextStyle.copyWith(
          fontFamily: fontFamily,
          fontWeight: FontUtil.medium,
        ),
        navLargeTitleTextStyle: textTheme.navLargeTitleTextStyle.copyWith(
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
