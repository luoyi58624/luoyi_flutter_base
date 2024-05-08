part of '../../luoyi_flutter_base.dart';

class ThemeDataUtil {
  ThemeDataUtil._();

  /// 根据注入的[AppData]构建[MaterialApp]主题，如果你没有包裹[AppData]，则使用默认值构建
  /// * context 用于获取[AppData]实例，如果在当前[Widget]下构建[AppData]和[MaterialApp]，
  /// 请使用[Builder]小部件包裹[MaterialApp]，这是常见的[context]作用域问题，请注意规避
  static ThemeData buildThemeData(BuildContext context, Brightness brightness) {
    AppData? appData = AppData.maybeOf(context);

    bool isDark = brightness == Brightness.dark;
    FlutterThemeData theme = isDark ? (appData?.darkTheme ?? FlutterThemeData.darkTheme) : (appData?.theme ?? FlutterThemeData.theme);
    FlutterConfigData config = appData?.config ?? FlutterConfigData.config;

    bool isM3 = config.useMaterial3;

    if (isM3) {
      SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(statusBarColor: Color.fromRGBO(0, 0, 0, 0)));
    } else {
      if (config.m2ConfigData.translucenceStatusBar) {
        SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(statusBarColor: Color.fromRGBO(0, 0, 0, 200)));
      } else {
        SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(statusBarColor: Color.fromRGBO(0, 0, 0, 0)));
      }
    }

    var themeData = ThemeData(
      useMaterial3: isM3,
      colorScheme: isM3 ? ColorScheme.fromSeed(brightness: brightness, seedColor: theme.primary) : null,
      primarySwatch: isM3 ? null : theme.primary.toMaterialColor(),
      brightness: isM3 ? null : brightness,
      // 设置默认字体
      fontFamily: config.fontFamily,
      // 设置优先加载的字体族列表
      // fontFamilyFallback: FontUtil._fontFamilyFallback,
      // 设置文字主题样式
      textTheme: isM3 ? FontUtil._textTheme(theme) : FontUtil._m2TextTheme(theme),
      primaryTextTheme: isM3 ? FontUtil._textTheme(theme) : FontUtil._m2TextTheme(theme),
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
      scaffoldBackgroundColor: theme.bgColor,
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        elevation: 0,
        backgroundColor: theme.bgColor2,
        selectedItemColor: theme.primary,
        unselectedLabelStyle: TextStyle(fontWeight: FontUtil.medium, fontSize: 12),
        selectedLabelStyle: TextStyle(fontWeight: FontUtil.medium, fontSize: 12),
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
      listTileTheme: ListTileThemeData(
        titleTextStyle: TextStyle(
          fontWeight: FontUtil.medium,
          color: theme.textColor,
          fontSize: 15,
        ),
        subtitleTextStyle: TextStyle(
          fontWeight: FontUtil.medium,
          color: theme.textColor2,
          fontSize: 13,
        ),
      ),
    );

    themeData = themeData.copyWith(
      appBarTheme: themeData.appBarTheme.copyWith(
        centerTitle: config.centerTitle,
        toolbarHeight: isM3 ? config.m3ConfigData.appbarHeight : config.m2ConfigData.appbarHeight,
        elevation: themeData.useMaterial3 ? 0 : config.m2ConfigData.appbarElevation,
        scrolledUnderElevation:
            themeData.useMaterial3 ? (config.m3ConfigData.appBarScrollShade ? 4 : 0) : config.m2ConfigData.appbarScrollElevation,
        backgroundColor: theme.headerColor,
        titleTextStyle: TextStyle(fontSize: 18, fontWeight: FontUtil.medium, color: theme.textColor),
        iconTheme: IconThemeData(color: theme.iconColor),
      ),
      iconTheme: IconThemeData(color: theme.iconColor),
    );

    if (GetPlatform.isWindows) {
      i('加载谷歌字体');
      themeData = themeData.copyWith(
        textTheme: GoogleFonts.notoSansScTextTheme(themeData.textTheme),
      );
    }else{
      themeData = themeData.copyWith(
        textTheme: GoogleFonts.notoSansScTextTheme(themeData.textTheme),
        // textTheme: GoogleFonts.longCangTextTheme(themeData.textTheme),
      );
    }
    return themeData;
  }

  static CupertinoThemeData buildCupertinoThemeData(BuildContext context, Brightness brightness) {
    AppData? appData = AppData.maybeOf(context);

    FlutterThemeData theme =
        brightness == Brightness.light ? (appData?.theme ?? FlutterThemeData.theme) : (appData?.darkTheme ?? FlutterThemeData.darkTheme);
    FlutterConfigData config = appData?.config ?? FlutterConfigData.config;

    var textTheme = const CupertinoThemeData().textTheme;
    return CupertinoThemeData(
      // brightness: theme.brightness,
      primaryColor: theme.primary,
      textTheme: CupertinoTextThemeData(
        textStyle: textTheme.textStyle.copyWith(
          fontFamily: config.fontFamily,
        ),
        tabLabelTextStyle: textTheme.tabLabelTextStyle.copyWith(
          fontSize: 12,
          fontFamily: config.fontFamily,
        ),
        navActionTextStyle: textTheme.navActionTextStyle.copyWith(
          color: theme.primary,
          fontFamily: config.fontFamily,
        ),
      ),
    );
  }
}
