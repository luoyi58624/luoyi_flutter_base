part of '../luoyi_flutter_base.dart';

class AppData extends InheritedWidget {
  /// App全局数据共享，一般配合[ThemeDataUtil]工具类构建主题，该组件可选，如果不提供，则使用默认实例构建主题
  const AppData({
    super.key,
    required super.child,
    required this.theme,
    required this.darkTheme,
    required this.config,
  });

  /// 亮色主题
  final AppThemeData theme;

  /// 暗色主题
  final AppThemeData darkTheme;

  /// 全局配置
  final AppConfigData config;

  static AppData? maybeOf(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<AppData>();
  }

  static AppData of(BuildContext context) {
    final AppData? result = maybeOf(context);
    assert(result != null, 'No AppData found in context');
    return result!;
  }

  @override
  bool updateShouldNotify(AppData oldWidget) {
    return true;
  }
}

/// [AppData]响应式控制器，基于[Getx] (可选)
class AppDataController extends GetxController {
  AppDataController({
    ThemeMode? themeMode,
    AppThemeData? theme,
    AppThemeData? darkTheme,
    AppConfigData? config,
  }) {
    _init(
      themeMode ?? ThemeMode.system,
      theme ?? AppThemeData.theme,
      darkTheme ?? AppThemeData.darkTheme,
      config ?? AppConfigData.config,
    );
  }

  static AppDataController of = Get.find();
  late final Rx<ThemeMode> themeMode;
  late final Rx<AppThemeData> theme;
  late final Rx<AppThemeData> darkTheme;
  late final Rx<AppConfigData> config;

  void _init(ThemeMode $themeMode, AppThemeData $theme, AppThemeData $darkTheme, AppConfigData $config) {
    themeMode = $themeMode.obs;
    theme = $theme.obs;
    darkTheme = $darkTheme.obs;
    config = $config.obs;
  }
}

extension AppDataContextExtension on BuildContext {
  /// 当前主题数据
  AppThemeData get appTheme => Theme.of(this).extension<AppThemeData>() ?? (isDarkMode ? AppThemeData.darkTheme : AppThemeData.theme);

  /// 全局配置数据
  AppConfigData get appConfig => AppData.maybeOf(this)?.config ?? AppConfigData.config;

  /// Appbar高度
  double get appbarHeight => Theme.of(this).useMaterial3 ? appConfig.m3ConfigData.appbarHeight : appConfig.m2ConfigData.appbarHeight;
}

extension FlutterThemeDataExtension on ThemeData {
  /// 应用[AppData]的主题数据和配置信息
  ThemeData applyAppData(BuildContext context) {
    AppData? appData = AppData.maybeOf(context);

    bool isDark = brightness == Brightness.dark;
    final lightTheme = appData?.theme ?? AppThemeData.theme;
    final darkTheme = appData?.darkTheme ?? AppThemeData.darkTheme;
    final theme = isDark ? darkTheme : lightTheme;
    AppConfigData config = appData?.config ?? AppConfigData.config;
    String? fontFamily = config.fontFamily ?? textTheme.displayLarge?.fontFamily;

    bool isM3 = config.useMaterial3 ?? useMaterial3;
    if (isM3) {
      SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(statusBarColor: Color.fromRGBO(0, 0, 0, 0)));
    } else {
      if (config.m2ConfigData.translucenceStatusBar) {
        AsyncUtil.delayed(() {
          SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(statusBarColor: Color.fromRGBO(0, 0, 0, 200)));
        }, 500);
      } else {
        SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(statusBarColor: Color.fromRGBO(0, 0, 0, 0)));
      }
    }

    return copyWith(
      useMaterial3: isM3,
      // 应用颜色主题
      colorScheme: isM3
          ? ColorScheme.fromSeed(
              brightness: brightness,
              seedColor: theme.primary,
            )
          : ColorScheme.fromSwatch(
              brightness: brightness,
              primarySwatch: theme.primary.toMaterialColor(),
            ),
      textTheme: _textTheme(theme, config),
      // 扩展主题
      extensions: [theme],
      // 是否禁用波纹
      splashFactory: config.enableRipple ? InkRipple.splashFactory : noRipperFactory,
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
      // 设置页面背景色
      scaffoldBackgroundColor: theme.bgColor,
      appBarTheme: appBarTheme.copyWith(
        centerTitle: config.centerTitle,
        toolbarHeight: isM3 ? config.m3ConfigData.appbarHeight : config.m2ConfigData.appbarHeight,
        elevation: isM3 ? 0 : config.m2ConfigData.appbarElevation,
        scrolledUnderElevation: isM3 ? (config.m3ConfigData.appBarScrollShade ? 4 : 0) : config.m2ConfigData.appbarScrollElevation,
        backgroundColor: theme.headerColor,
        titleTextStyle: TextStyle(
          fontFamily: fontFamily,
          fontSize: 18,
          fontWeight: FontWeight.w500,
          color: theme.headerColor.isDark ? darkTheme.textColor : lightTheme.textColor,
        ),
        iconTheme: IconThemeData(
          color: theme.headerColor.isDark ? darkTheme.iconColor : lightTheme.iconColor,
        ),
      ),
      // 设置底部导航栏
      bottomNavigationBarTheme: bottomNavigationBarTheme.copyWith(
        elevation: 0,
        backgroundColor: theme.bgColor2,
        selectedItemColor: theme.primary,
        unselectedLabelStyle: TextStyle(fontFamily: fontFamily, fontWeight: FontWeight.w500, fontSize: 12),
        selectedLabelStyle: TextStyle(fontFamily: fontFamily, fontWeight: FontWeight.w500, fontSize: 12),
        unselectedIconTheme: IconThemeData(size: 26, color: theme.iconColor2),
        selectedIconTheme: IconThemeData(size: 26, color: theme.primary),
      ),
      iconTheme: IconThemeData(color: theme.iconColor),
      cardTheme: CardTheme(
        color: theme.bgColor2,
        // m3会将此颜色和color进行混合从而产生一个新的material颜色 (生成一个淡淡的Primary Color)，
        // 这里将其重置为透明，表示卡片用默认color展示
        surfaceTintColor: Colors.transparent,
        elevation: isDark ? 4 : 1,
        margin: const EdgeInsets.all(8),
      ),
      inputDecorationTheme: const InputDecorationTheme(
        border: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey),
        ),
      ),
      expansionTileTheme: ExpansionTileThemeData(
        textColor: theme.primary,
        shape: Border.all(width: 0, style: BorderStyle.none),
        collapsedShape: Border.all(width: 0, style: BorderStyle.none),
      ),
      popupMenuTheme: popupMenuTheme.copyWith(
        color: theme.bgColor3,
        surfaceTintColor: Colors.transparent,
        elevation: isDark ? 8 : 2,
        enableFeedback: true,
        textStyle: TextStyle(
          fontFamily: fontFamily,
          fontWeight: FontWeight.w500,
          color: theme.textColor,
          fontSize: 14,
        ),
      ),
      listTileTheme: listTileTheme.copyWith(
        titleTextStyle: TextStyle(
          fontFamily: fontFamily,
          fontWeight: FontWeight.w500,
          color: theme.textColor,
          fontSize: 15,
        ),
        subtitleTextStyle: TextStyle(
          fontFamily: fontFamily,
          fontWeight: FontWeight.w500,
          color: theme.textColor2,
          fontSize: 13,
        ),
        iconColor: theme.iconColor,
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
        ),
        navTitleTextStyle: textTheme.navTitleTextStyle.copyWith(
          fontFamily: fontFamily,
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
      color: theme.textColor,
      fontFamily: config.fontFamily,
      fontFamilyFallback: config.fontFamilyFallback,
    ),
    displayMedium: TextStyle(
      color: theme.textColor,
      fontFamily: config.fontFamily,
      fontFamilyFallback: config.fontFamilyFallback,
    ),
    displaySmall: TextStyle(
      color: theme.textColor,
      fontFamily: config.fontFamily,
      fontFamilyFallback: config.fontFamilyFallback,
    ),
    headlineLarge: TextStyle(
      color: theme.textColor,
      fontFamily: config.fontFamily,
      fontFamilyFallback: config.fontFamilyFallback,
    ),
    headlineMedium: TextStyle(
      color: theme.textColor,
      fontFamily: config.fontFamily,
      fontFamilyFallback: config.fontFamilyFallback,
    ),
    headlineSmall: TextStyle(
      color: theme.textColor,
      fontFamily: config.fontFamily,
      fontFamilyFallback: config.fontFamilyFallback,
    ),
    titleLarge: TextStyle(
      color: theme.textColor,
      fontFamily: config.fontFamily,
      fontFamilyFallback: config.fontFamilyFallback,
    ),
    titleMedium: TextStyle(
      color: theme.textColor,
      fontFamily: config.fontFamily,
      fontFamilyFallback: config.fontFamilyFallback,
    ),
    titleSmall: TextStyle(
      color: theme.textColor,
      fontFamily: config.fontFamily,
      fontFamilyFallback: config.fontFamilyFallback,
    ),
    bodyLarge: TextStyle(
      color: theme.textColor,
      fontFamily: config.fontFamily,
      fontFamilyFallback: config.fontFamilyFallback,
    ),
    bodyMedium: TextStyle(
      color: theme.textColor,
      fontFamily: config.fontFamily,
      fontFamilyFallback: config.fontFamilyFallback,
    ),
    bodySmall: TextStyle(
      color: theme.textColor,
      fontFamily: config.fontFamily,
      fontFamilyFallback: config.fontFamilyFallback,
    ),
    labelLarge: TextStyle(
      color: theme.textColor,
      fontFamily: config.fontFamily,
      fontFamilyFallback: config.fontFamilyFallback,
    ),
    labelMedium: TextStyle(
      color: theme.textColor,
      fontFamily: config.fontFamily,
      fontFamilyFallback: config.fontFamilyFallback,
    ),
    labelSmall: TextStyle(
      color: theme.textColor,
      fontFamily: config.fontFamily,
      fontFamilyFallback: config.fontFamilyFallback,
    ),
  );
}
