part of '../../luoyi_flutter_base.dart';

class FlutterColorData {
  FlutterColorData._();

  static Map<String, MaterialColor> materialColors = {
    'cyan': Colors.cyan,
    'green': Colors.green,
    'amber': Colors.amber,
    'indigo': Colors.indigo,
    'blue': Colors.blue,
    'red': Colors.red,
    'purple': Colors.purple,
    'blueGrey': Colors.blueGrey,
    'brown': Colors.brown,
    'yellow': Colors.yellow,
    'teal': Colors.teal,
    'lightBlue': Colors.lightBlue,
    'lime': Colors.lime,
    'lightGreen': Colors.lightGreen,
    'grey': Colors.grey,
    'pink': Colors.pink,
    'deepOrange': Colors.deepOrange,
  };

  static List<int> materialColorSwatchs = [50, 100, 200, 300, 400, 500, 600, 700, 800, 900];

  static List<Color> get expandMaterialSwatchColors {
    return [
      ...materialColorSwatchs.map((e) => Colors.cyan[e]!),
      ...materialColorSwatchs.map((e) => Colors.green[e]!),
      ...materialColorSwatchs.map((e) => Colors.amber[e]!),
      ...materialColorSwatchs.map((e) => Colors.indigo[e]!),
      ...materialColorSwatchs.map((e) => Colors.blue[e]!),
      ...materialColorSwatchs.map((e) => Colors.red[e]!),
      ...materialColorSwatchs.map((e) => Colors.purple[e]!),
      ...materialColorSwatchs.map((e) => Colors.blueGrey[e]!),
      ...materialColorSwatchs.map((e) => Colors.brown[e]!),
      ...materialColorSwatchs.map((e) => Colors.yellow[e]!),
      ...materialColorSwatchs.map((e) => Colors.teal[e]!),
      ...materialColorSwatchs.map((e) => Colors.lightBlue[e]!),
      ...materialColorSwatchs.map((e) => Colors.lime[e]!),
      ...materialColorSwatchs.map((e) => Colors.lightGreen[e]!),
      ...materialColorSwatchs.map((e) => Colors.grey[e]!),
      ...materialColorSwatchs.map((e) => Colors.pink[e]!),
      ...materialColorSwatchs.map((e) => Colors.deepOrange[e]!),
    ];
  }
}

class DemoUtil {
  /// 将动态类型转换成实际基础类型：String、int、double、num、bool，如果
  /// * strict 如果为true，对于非基础类型将一律返回null
  static dynamic dynamicToBaseType(dynamic value, [bool? strict]) {
    String type = value.runtimeType.toString();
    if (type == 'String') {
      dynamic v = int.tryParse(value);
      if (v != null) return v;
      v = double.tryParse(value);
      if (v != null) return v;
      v = bool.tryParse(value);
      if (v != null) return v;
      return value;
    }
    if (type == 'int') return value;
    if (type == 'double') return value;
    if (type == 'bool') return value;
    if (type == 'num') return value;
    return strict == true ? null : value;
  }

  /// 自动转换Map的实际类型
  static Map autoCastMap<K, V>(Map<K, V> map) {
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

    map.forEach((k, v) {
      dynamic key = dynamicToBaseType(k, true);
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

      dynamic value = dynamicToBaseType(v);
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
      } else if (value is Map) {
      } else {
        valueTypeMap['object'] = true;
      }
    });

    keyTypeMap = filterMap(keyTypeMap, (k, v) => v == true);
    valueTypeMap = filterMap(valueTypeMap, (k, v) => v == true);

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
      if (targetValueType == 'object') return LinkedHashMap<Object, Object>.from(map);
      if (targetValueType == 'string') return LinkedHashMap<Object, String>.from(map);
      if (targetValueType == 'int') return LinkedHashMap<Object, int>.from(map);
      if (targetValueType == 'double') return LinkedHashMap<Object, double>.from(map);
      if (targetValueType == 'num') return LinkedHashMap<Object, num>.from(map);
      if (targetValueType == 'bool') return LinkedHashMap<Object, bool>.from(map);
      return map.cast<Object, dynamic>();
    } else {
      if (targetKeyType == 'string') {
        if (targetValueType == 'object') return LinkedHashMap<String, Object>.from(map);
        if (targetValueType == 'string') return LinkedHashMap<String, String>.from(map);
        if (targetValueType == 'int') return LinkedHashMap<String, int>.from(map);
        if (targetValueType == 'double') return LinkedHashMap<String, double>.from(map);
        if (targetValueType == 'num') return LinkedHashMap<String, num>.from(map);
        if (targetValueType == 'bool') return LinkedHashMap<String, bool>.from(map);
        return LinkedHashMap<String, dynamic>.from(map);
      }
      if (targetKeyType == 'int') {
        if (targetValueType == 'object') return LinkedHashMap<int, Object>.from(map);
        if (targetValueType == 'string') return LinkedHashMap<int, String>.from(map);
        if (targetValueType == 'int') return LinkedHashMap<int, int>.from(map);
        if (targetValueType == 'double') return LinkedHashMap<int, double>.from(map);
        if (targetValueType == 'num') return LinkedHashMap<int, num>.from(map);
        if (targetValueType == 'bool') return LinkedHashMap<int, bool>.from(map);
        return LinkedHashMap<int, dynamic>.from(map);
      }

      if (targetKeyType == 'double') {
        if (targetValueType == 'object') return LinkedHashMap<double, Object>.from(map);
        if (targetValueType == 'string') return LinkedHashMap<double, String>.from(map);
        if (targetValueType == 'int') return LinkedHashMap<double, int>.from(map);
        if (targetValueType == 'double') return LinkedHashMap<double, double>.from(map);
        if (targetValueType == 'num') return LinkedHashMap<double, num>.from(map);
        if (targetValueType == 'bool') return LinkedHashMap<double, bool>.from(map);
        return LinkedHashMap<double, dynamic>.from(map);
      }
      if (targetKeyType == 'bool') {
        if (targetValueType == 'object') return LinkedHashMap<bool, Object>.from(map);
        if (targetValueType == 'string') return LinkedHashMap<bool, String>.from(map);
        if (targetValueType == 'int') return LinkedHashMap<bool, int>.from(map);
        if (targetValueType == 'double') return LinkedHashMap<bool, double>.from(map);
        if (targetValueType == 'num') return LinkedHashMap<bool, num>.from(map);
        if (targetValueType == 'bool') return LinkedHashMap<bool, bool>.from(map);
        return LinkedHashMap<bool, dynamic>.from(map);
      }

      if (targetValueType == 'object') return LinkedHashMap<num, Object>.from(map);
      if (targetValueType == 'string') return LinkedHashMap<num, String>.from(map);
      if (targetValueType == 'int') return LinkedHashMap<num, int>.from(map);
      if (targetValueType == 'double') return LinkedHashMap<num, double>.from(map);
      if (targetValueType == 'num') return LinkedHashMap<num, num>.from(map);
      if (targetValueType == 'bool') return LinkedHashMap<num, bool>.from(map);
      return LinkedHashMap<num, dynamic>.from(map);
    }
  }

  /// 根据条件返回一个新的Map
  static Map<K, V> filterMap<K, V>(Map<K, V> map, bool Function(K key, V value) test) {
    Map<K, V> newMap = {};
    for (K k in map.keys) {
      if (test(k, map[k] as V)) {
        newMap[k] = map[k] as V;
      }
    }
    return newMap;
  }

  /// 根据keys集合，返回一个新的Map
  static Map<K, V> filterFromKeys<K, V>(Map<K, V> map, List<K> keys) {
    Map<K, V> newMap = {};
    for (K key in map.keys) {
      newMap[key] = map[key] as V;
    }
    return newMap;
  }
}
