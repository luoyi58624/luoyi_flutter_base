part of '../../luoyi_flutter_base.dart';

extension FlutterMapExtension<K, V> on Map<K, V> {
  /// 自动转换Map的实际类型
  Map autoCast() {
    Map<String, bool> keyTypeMap = {
      'dynamic': false,
      'string': false,
      'int': false,
      'double': false,
      'num': false,
      'bool': false,
    };

    Map<String, bool> valueTypeMap = {
      'dynamic': false,
      'string': false,
      'int': false,
      'double': false,
      'num': false,
      'bool': false,
      'null': false,
      'object': false,
    };

    forEach((k, v) {
      dynamic key = DemoUtil.dynamicToBaseType(k, true);
      assert(key != null, 'Map key不是基础数据类型，autoCast失败');
      if (key is int) {
        keyTypeMap['int'] = true;
      } else if (key is double) {
        keyTypeMap['double'] = true;
      } else if (key is bool) {
        keyTypeMap['bool'] = true;
      } else {
        keyTypeMap['string'] = true;
      }

      dynamic value = DemoUtil.dynamicToBaseType(v);
      if (value == null) {
        valueTypeMap['null'] = true;
      } else if (value is int) {
        valueTypeMap['int'] = true;
      } else if (value is double) {
        valueTypeMap['double'] = true;
      } else if (value is bool) {
        valueTypeMap['bool'] = true;
      } else if (value is String) {
        valueTypeMap['string'] = true;
      } else {
        valueTypeMap['object'] = true;
      }
    });

    keyTypeMap = keyTypeMap.filterMap((k, v) => v == true);
    valueTypeMap = valueTypeMap.filterMap((k, v) => v == true);

    late String targetKeyType;
    late String targetValueType;

    if (keyTypeMap.length == 1) {
      targetKeyType = keyTypeMap.keys.first;
    } else if (keyTypeMap.length == 3 && keyTypeMap['num'] == true) {
      targetKeyType = 'num';
    } else {
      targetKeyType = 'dynamic';
    }

    if (valueTypeMap.length == 1) {
      targetValueType = valueTypeMap.keys.first;
    } else if (valueTypeMap.length == 3 && valueTypeMap['num'] == true) {
      targetValueType = 'num';
    } else {
      targetValueType = valueTypeMap['null'] == true ? 'dynamic' : 'object';
    }

    if (targetKeyType == 'dynamic') {
      if (targetValueType == 'object') return LinkedHashMap<Object, Object>.from(this);
      if (targetValueType == 'string') return LinkedHashMap<Object, String>.from(this);
      if (targetValueType == 'int') return LinkedHashMap<Object, int>.from(this);
      if (targetValueType == 'double') return LinkedHashMap<Object, double>.from(this);
      if (targetValueType == 'num') return LinkedHashMap<Object, num>.from(this);
      if (targetValueType == 'bool') return LinkedHashMap<Object, bool>.from(this);
      return LinkedHashMap<Object, dynamic>.from(this);
    } else {
      if (targetKeyType == 'string') {
        if (targetValueType == 'object') return LinkedHashMap<String, Object>.from(this);
        if (targetValueType == 'string') return LinkedHashMap<String, String>.from(this);
        if (targetValueType == 'int') return LinkedHashMap<String, int>.from(this);
        if (targetValueType == 'double') return LinkedHashMap<String, double>.from(this);
        if (targetValueType == 'num') return LinkedHashMap<String, num>.from(this);
        if (targetValueType == 'bool') return LinkedHashMap<String, bool>.from(this);
        return LinkedHashMap<String, dynamic>.from(this);
      }
      if (targetKeyType == 'int') {
        if (targetValueType == 'object') return LinkedHashMap<int, Object>.from(this);
        if (targetValueType == 'string') return LinkedHashMap<int, String>.from(this);
        if (targetValueType == 'int') return LinkedHashMap<int, int>.from(this);
        if (targetValueType == 'double') return LinkedHashMap<int, double>.from(this);
        if (targetValueType == 'num') return LinkedHashMap<int, num>.from(this);
        if (targetValueType == 'bool') return LinkedHashMap<int, bool>.from(this);
        return LinkedHashMap<int, dynamic>.from(this);
      }

      if (targetKeyType == 'double') {
        if (targetValueType == 'object') return LinkedHashMap<double, Object>.from(this);
        if (targetValueType == 'string') return LinkedHashMap<double, String>.from(this);
        if (targetValueType == 'int') return LinkedHashMap<double, int>.from(this);
        if (targetValueType == 'double') return LinkedHashMap<double, double>.from(this);
        if (targetValueType == 'num') return LinkedHashMap<double, num>.from(this);
        if (targetValueType == 'bool') return LinkedHashMap<double, bool>.from(this);
        return LinkedHashMap<double, dynamic>.from(this);
      }
      if (targetKeyType == 'bool') {
        if (targetValueType == 'object') return LinkedHashMap<bool, Object>.from(this);
        if (targetValueType == 'string') return LinkedHashMap<bool, String>.from(this);
        if (targetValueType == 'int') return LinkedHashMap<bool, int>.from(this);
        if (targetValueType == 'double') return LinkedHashMap<bool, double>.from(this);
        if (targetValueType == 'num') return LinkedHashMap<bool, num>.from(this);
        if (targetValueType == 'bool') return LinkedHashMap<bool, bool>.from(this);
        return LinkedHashMap<bool, dynamic>.from(this);
      }

      if (targetValueType == 'object') return LinkedHashMap<num, Object>.from(this);
      if (targetValueType == 'string') return LinkedHashMap<num, String>.from(this);
      if (targetValueType == 'int') return LinkedHashMap<num, int>.from(this);
      if (targetValueType == 'double') return LinkedHashMap<num, double>.from(this);
      if (targetValueType == 'num') return LinkedHashMap<num, num>.from(this);
      if (targetValueType == 'bool') return LinkedHashMap<num, bool>.from(this);
      return LinkedHashMap<num, dynamic>.from(this);
    }
  }

  /// 根据条件返回一个新的Map
  Map<K, V> filterMap(bool Function(K key, V value) test) {
    var map = Map.from(this);
    Map<K, V> newMap = {};
    for (K k in map.keys) {
      if (test(k, map[k] as V)) {
        newMap[k] = map[k] as V;
      }
    }
    return newMap;
  }
}

extension FlutterStringExtension on String {
  bool get isInt => int.tryParse(this) != null;

  bool get isDouble => double.tryParse(this) != null;

  bool get isBool => bool.tryParse(this) != null;

  /// 将16进制字符串颜色转成Color对象
  Color toColor() {
    final buffer = StringBuffer();
    if (length == 6 || length == 7) buffer.write('ff');
    buffer.write(replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }
}

/// Color工具函数扩展
extension FlutterColorExtension on Color {
  /// 判断一个颜色是否是暗色
  bool get isDark => hsp <= 168;

  /// 返回一个颜色的hsp (颜色的感知亮度)
  ///
  /// http://www.w3.org/TR/AERT#color-contrast
  int get hsp => ((red * 299 + green * 587 + blue * 114) / 1000).ceilToDouble().toInt();

  /// 根据明亮度获取一个新的颜色，lightness以1为基准，小于1则颜色变暗，大于1则颜色变亮
  Color getLightnessColor(double lightness) {
    final originalColor = HSLColor.fromColor(this);
    final newLightness = originalColor.lightness * lightness;
    final newColor = originalColor.withLightness(newLightness.clamp(0.0, 1.0));
    return newColor.toColor();
  }

  /// Color对象转16进制字符串格式颜色
  /// * hasLeading 是否添加 # 前缀，默认true
  /// * hasAlpha 是否添加透明度，默认false
  String toHex({
    bool hasLeading = true,
    bool hasAlpha = false,
  }) =>
      '${hasLeading == true ? '#' : ''}'
      '${hasAlpha == true ? alpha.toRadixString(16).padLeft(2, '0') : ''}'
      '${red.toRadixString(16).padLeft(2, '0')}'
      '${green.toRadixString(16).padLeft(2, '0')}'
      '${blue.toRadixString(16).padLeft(2, '0')}';

  /// 创建Material颜色
  MaterialColor toMaterialColor() {
    List strengths = <double>[.05];
    Map<int, Color> swatch = {};

    for (int i = 1; i < 10; i++) {
      strengths.add(0.1 * i);
    }
    for (var strength in strengths) {
      final double ds = 0.5 - strength;
      swatch[(strength * 1000).round()] = Color.fromRGBO(
        red + ((ds < 0 ? red : (255 - red)) * ds).round(),
        green + ((ds < 0 ? green : (255 - green)) * ds).round(),
        blue + ((ds < 0 ? blue : (255 - blue)) * ds).round(),
        1,
      );
    }
    return MaterialColor(value, swatch);
  }

  /// 将颜色变得更亮
  /// * scale 0-100，值越大，颜色越亮
  Color brighten(int scale) {
    assert(scale >= 0 && scale <= 100);
    var p = scale / 100;
    return Color.fromARGB(
        alpha, red + ((255 - red) * p).round(), green + ((255 - green) * p).round(), blue + ((255 - blue) * p).round());
  }

  /// 将颜色变得更暗
  /// * scale 0-100，值越大，颜色越深
  Color darken(int scale) {
    assert(scale >= 0 && scale <= 100);
    var f = 1 - scale / 100;
    return Color.fromARGB(alpha, (red * f).round(), (green * f).round(), (blue * f).round());
  }

  /// 将颜色变得深，如果当前颜色是亮色，颜色会变暗，但如果当前颜色是暗色，则颜色会变亮
  /// * scale 0-100，值越大，颜色越深
  /// * lightScale 0-100，当颜色是亮色时，应用的 scale 值
  /// * darkScale 0-100，当颜色是暗色时，应用的 scale 值
  Color deepen(
    int scale, {
    int? lightScale,
    int? darkScale,
  }) {
    return isDark ? brighten(darkScale ?? scale) : darken(lightScale ?? scale);
  }

  /// 当用户鼠标悬停时的颜色
  Color onHover(BuildContext context, bool flag, [int? scale]) =>
      flag ? deepen(scale ?? context.appConfig.hoverScale) : this;

  /// 当用户鼠标、手指按下时的颜色
  Color onTap(BuildContext context, bool flag, [int? scale]) =>
      flag ? deepen(scale ?? context.appConfig.tapScale) : this;
}
