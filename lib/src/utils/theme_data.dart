part of '../../luoyi_flutter_base.dart';

class ThemeDataUtil {
  ThemeDataUtil._();

  /// 根据注入的[AppData]构建[MaterialApp]主题，如果你没有包裹[AppData]，则使用默认值构建
  /// * context 用于获取[AppData]实例，如果在当前[Widget]下构建[AppData]和[MaterialApp]，
  /// 请使用[Builder]小部件包裹[MaterialApp]，这是常见的[context]作用域问题，请注意规避
  static ThemeData buildThemeData(BuildContext context, Brightness brightness) {
    AppData? appData = AppData.maybeOf(context);

    FlutterThemeData theme = brightness == Brightness.light
        ? (appData?.theme ?? FlutterThemeData.theme)
        : (appData?.darkTheme ?? FlutterThemeData.darkTheme);
    FlutterConfigData config = appData?.config ?? FlutterConfigData.config;

    ColorScheme colorScheme = ColorScheme.fromSeed(
      brightness: brightness,
      seedColor: theme.primary,
    );

    if (config.useMaterial3) {
      SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(statusBarColor: Color.fromRGBO(0, 0, 0, 0)));
    } else {
      if (config.m2ConfigData.translucenceStatusBar) {
        SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(statusBarColor: Color.fromRGBO(0, 0, 0, 200)));
      } else {
        SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(statusBarColor: Color.fromRGBO(0, 0, 0, 0)));
      }
    }

    final themeData = ThemeData(
      useMaterial3: config.useMaterial3,
      primarySwatch: config.useMaterial3 ? null : theme.primary.toMaterialColor(),
      colorScheme: config.useMaterial3 ? colorScheme : null,
      fontFamilyFallback: FontUtil._fontFamilyFallback,
      // 设置文字主题样式
      textTheme: FontUtil._textTheme,
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
      cardTheme: CardTheme(
        surfaceTintColor: Colors.transparent,
        color: theme.bgColor2,
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
    );

    return themeData.copyWith(
      appBarTheme: themeData.appBarTheme.copyWith(
        centerTitle: config.centerTitle,
        toolbarHeight: config.headerHeight,
        elevation: themeData.useMaterial3 ? 0 : config.m2ConfigData.appBarElevation,
        scrolledUnderElevation: themeData.useMaterial3
            ? (config.m3ConfigData.appBarScrollShade ? 4 : 0)
            : config.m2ConfigData.appBarScrollElevation,
        backgroundColor: theme.headerColor,
        titleTextStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: theme.iconColor),
        iconTheme: IconThemeData(color: theme.iconColor),
      ),
      iconTheme: IconThemeData(color: theme.iconColor),
    );
  }

  static CupertinoThemeData buildCupertinoThemeData(BuildContext context, Brightness brightness) {
    AppData? appData = AppData.maybeOf(context);

    FlutterThemeData theme = brightness == Brightness.light
        ? (appData?.theme ?? FlutterThemeData.theme)
        : (appData?.darkTheme ?? FlutterThemeData.darkTheme);
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
