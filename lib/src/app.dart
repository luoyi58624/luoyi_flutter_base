part of '../luoyi_flutter_base.dart';

extension AppDataContextExtension on BuildContext {
  /// 当前主题数据
  FlutterThemeData get currentThemeData =>
      Theme.of(this).extension<FlutterThemeData>() ?? (isDarkMode ? FlutterThemeData.darkTheme : FlutterThemeData.theme);

  /// 全局配置数据
  FlutterConfigData get configData => AppData.maybeOf(this)?.config ?? FlutterConfigData.config;

  /// Appbar高度
  double get appbarHeight => Theme.of(this).useMaterial3 ? configData.m3ConfigData.appbarHeight : configData.m2ConfigData.appbarHeight;
}

extension FlutterThemeDataExtension on ThemeData {
  /// 应用[AppData]的主题数据和配置信息
  ThemeData applyAppData(BuildContext context) {
    AppData? appData = AppData.maybeOf(context);

    bool isDark = brightness == Brightness.dark;
    FlutterThemeData theme = isDark ? (appData?.darkTheme ?? FlutterThemeData.darkTheme) : (appData?.theme ?? FlutterThemeData.theme);
    FlutterConfigData config = appData?.config ?? FlutterConfigData.config;
    String? fontFamily = config.fontFamily ?? textTheme.displayLarge?.fontFamily;

    bool isM3 = config.useMaterial3 ?? useMaterial3;
    if (isM3) {
      SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(statusBarColor: Color.fromRGBO(0, 0, 0, 0)));
    } else {
      if (config.m2ConfigData.translucenceStatusBar) {
        SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(statusBarColor: Color.fromRGBO(0, 0, 0, 200)));
      } else {
        SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(statusBarColor: Color.fromRGBO(0, 0, 0, 0)));
      }
    }
    return copyWith(
      useMaterial3: isM3,
      // 应用颜色主题
      colorScheme: ColorScheme.fromSeed(brightness: brightness, seedColor: theme.primary),
      // 如果是m2，我们需要在这里设置 brightness
      brightness: isM3 ? null : brightness,
      primaryColor: theme.primary,
      textTheme: FontUtil._textTheme(theme, config),
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
      // 设置底部导航栏
      bottomNavigationBarTheme: bottomNavigationBarTheme.copyWith(
        elevation: 0,
        backgroundColor: theme.bgColor2,
        selectedItemColor: theme.primary,
        unselectedLabelStyle: TextStyle(fontFamily: fontFamily, fontWeight: FontUtil.medium, fontSize: 12),
        selectedLabelStyle: TextStyle(fontFamily: fontFamily, fontWeight: FontUtil.medium, fontSize: 12),
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
      popupMenuTheme: PopupMenuThemeData(
        color: theme.bgColor3,
        surfaceTintColor: Colors.transparent,
        elevation: isDark ? 8 : 2,
        enableFeedback: true,
        textStyle: TextStyle(fontSize: 14, color: theme.textColor, fontWeight: FontUtil.medium),
      ),
      listTileTheme: listTileTheme.copyWith(
        titleTextStyle: TextStyle(
          fontFamily: fontFamily,
          fontWeight: FontUtil.medium,
          color: theme.textColor,
          fontSize: 15,
        ),
        subtitleTextStyle: TextStyle(
          fontFamily: fontFamily,
          fontWeight: FontUtil.medium,
          color: theme.textColor2,
          fontSize: 13,
        ),
      ),
      // radioTheme: radioTheme.copyWith(fillColor: MaterialStatePropertyAll(theme.primary)),
      appBarTheme: appBarTheme.copyWith(
        centerTitle: config.centerTitle,
        toolbarHeight: isM3 ? config.m3ConfigData.appbarHeight : config.m2ConfigData.appbarHeight,
        elevation: isM3 ? 0 : config.m2ConfigData.appbarElevation,
        scrolledUnderElevation: isM3 ? (config.m3ConfigData.appBarScrollShade ? 4 : 0) : config.m2ConfigData.appbarScrollElevation,
        backgroundColor: theme.headerColor,
        titleTextStyle: TextStyle(fontFamily: fontFamily, fontSize: 18, fontWeight: FontWeight.w500, color: theme.textColor),
        iconTheme: IconThemeData(color: theme.iconColor),
      ),
    );
  }
}

extension FlutterCupertinoThemeDataExtension on CupertinoThemeData {
  CupertinoThemeData applyAppData(BuildContext context) {
    AppData? appData = AppData.maybeOf(context);

    FlutterThemeData theme =
        brightness == Brightness.light ? (appData?.theme ?? FlutterThemeData.theme) : (appData?.darkTheme ?? FlutterThemeData.darkTheme);

    FlutterConfigData config = appData?.config ?? FlutterConfigData.config;
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
  final FlutterThemeData theme;

  /// 暗色主题
  final FlutterThemeData darkTheme;

  /// 全局配置
  final FlutterConfigData config;

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
    FlutterThemeData? theme,
    FlutterThemeData? darkTheme,
    FlutterConfigData? config,
  }) {
    _init(
      themeMode ?? ThemeMode.system,
      theme ?? FlutterThemeData.theme,
      darkTheme ?? FlutterThemeData.darkTheme,
      config ?? FlutterConfigData.config,
    );
  }

  static AppDataController of = Get.find();
  late final Rx<ThemeMode> themeMode;
  late final Rx<FlutterThemeData> theme;
  late final Rx<FlutterThemeData> darkTheme;
  late final Rx<FlutterConfigData> config;

  void _init(ThemeMode $themeMode, FlutterThemeData $theme, FlutterThemeData $darkTheme, FlutterConfigData $config) {
    themeMode = $themeMode.obs;
    theme = $theme.obs;
    darkTheme = $darkTheme.obs;
    config = $config.obs;
  }
}
