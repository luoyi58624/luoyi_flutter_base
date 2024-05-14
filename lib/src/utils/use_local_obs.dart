part of '../../luoyi_flutter_base.dart';

class _LocalDataModel extends ExpireLocalDataModel {
  /// 持久化数据类型字符串，如果类型发生变化将清除旧的本地数据
  late String type;

  _LocalDataModel(this.type, super.data, [super.expire]);

  _LocalDataModel.fromJson(Map<String, dynamic> json) : super.fromJson(json) {
    type = json['type'] ?? '';
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'type': type,
      ...super.toJson(),
    };
  }
}

/// 序列化函数类型声明，[LocalStorage]可以自动转换基础数据类型、List、Map，但模型对象需要你手动转换，
/// 示例：
/// ```dart
/// // 创建的模型对象提供 toJson、fromJson 两种序列化方法即可，它们均可以自动生成
/// serializeFun: (model) => jsonEncode(model.toJson()),
/// deserializeFun: (json) => UserModel.fromJson(jsonDecode(json))
/// ```
/// 注意：List、Map如果存放的是模型对象，你也必须进行手动转换
typedef SerializeFun<T> = String Function(T model);

/// 反序列化函数类型声明
typedef DeserializeFun<T> = T Function(String json);

/// Getx本地响应式变量，注意：使用前需要初始化[localStorage]
/// ```dart
/// class Controller extends GetxController {
///   late final count = useLocalObs(0, 'local_count');
/// }
/// ```
extension GetxLocalObs on GetxController {
  /// 创建[Getx]响应式变量，更新时会同步至本地，重新加载时会取本地数据作为初始值
  /// * value - 初始值
  /// * key - 本地缓存key，请确保它们唯一
  /// * clear - 清除本地缓存，此属性一般用于重置本地数据
  /// * expire - 过期时间，单位毫秒，如果小于等于 0 则表示永不过期
  /// * serializeFun - 序列化函数，如果你传入的是对象，你必须将其转换为字符串才能缓存在本地
  /// * deserializeFun - 反序列化函数，将本地存储的字符串转回目标对象
  ///
  /// 序列化一个模型对象示例：
  /// ```dart
  /// serializeFun: (model) => jsonEncode(model.toJson()),
  /// deserializeFun: (json) => UserModel.fromJson(jsonDecode(json))
  /// ```
  Rx<T> useLocalObs<T>(
    T value,
    String key, {
    bool clear = false,
    int expire = -1,
    SerializeFun<T>? serializeFun,
    DeserializeFun<T>? deserializeFun,
  }) {
    if (clear) localStorage.removeItem(key);
    String valueType = T.toString();
    bool isBaseType = DartUtil.isBaseTypeString(valueType) || value is Map;

    /// 序列化Color对象
    if (value is Color) {
      serializeFun ??= (value) => (value as Color).toHex();
      deserializeFun ??= (value) => value.toColor() as T;
    }
    assert(isBaseType || (serializeFun != null && deserializeFun != null), '请为响应式持久化变量[$key]提供序列化和反序列化函数');
    late Rx<T> $value;
    dynamic localData = localStorage.getItem(key);
    if (localData == null) {
      $value = value.obs;
    } else {
      var localDataModel = _LocalDataModel.fromJson(jsonDecode(localData));
      if (localDataModel.type != valueType) {
        // 如果更改了响应式变量类型，则清除旧数据
        localStorage.removeItem(key);
        $value = value.obs;
      } else if (localDataModel.expire! > 0 && localDataModel.expire! < DateTime.now().millisecondsSinceEpoch) {
        // 如果用户设置了过期时间，同时过期时间小于当前时间，则清除旧数据
        localStorage.removeItem(key);
        $value = value.obs;
      } else {
        if (isBaseType && deserializeFun == null) {
          $value = (localDataModel.data as T).obs;
        } else {
          $value = deserializeFun!(localDataModel.data).obs;
        }
      }
    }
    // 提示：当你卸载控制器后getx会自动释放它，无须手动销毁
    ever($value, (v) {
      localStorage.setItem(
        key,
        jsonEncode(
          _LocalDataModel(
            valueType,
            serializeFun == null ? v : serializeFun(v),
            expire,
          ).toJson(),
        ),
      );
    });
    return $value;
  }

  /// 创建[Getx]响应式[List]，更新时会同步至本地，重新加载时会取本地数据作为初始值
  /// * value - 初始值
  /// * key - 本地缓存key，请确保它们唯一
  ///
  /// * clear - 清除本地缓存，此属性一般用于重置本地数据
  /// * expire - 过期时间，单位秒，如果小于等于 0 则表示永不过期
  /// * serializeFun - 序列化函数，如果你传入的是对象，你必须将其转换为字符串才能缓存在本地
  /// * deserializeFun - 反序列化函数，将本地存储的字符串转回目标对象
  RxList<T> useLocalListObs<T>(
    List<T> value,
    String key, {
    bool clear = false,
    int expire = -1,
    SerializeFun<T>? serializeFun,
    DeserializeFun<T>? deserializeFun,
  }) {
    if (clear) localStorage.removeItem(key);
    String valueType = T.toString();
    bool isBaseType = DartUtil.isBaseTypeString(valueType) || value is List<Map>;
    assert(isBaseType || (serializeFun != null && deserializeFun != null), '请为响应式持久化变量[$key]提供序列化和反序列化函数');
    late RxList<T> $value;
    dynamic localData = localStorage.getItem(key);
    if (localData == null) {
      $value = value.obs;
    } else {
      var localDataModel = _LocalDataModel.fromJson(jsonDecode(localData));
      if (localDataModel.type != valueType) {
        // 如果更改了响应式变量类型，则清除旧数据
        localStorage.removeItem(key);
        $value = value.obs;
      } else if (localDataModel.expire! > 0 && localDataModel.expire! < DateTime.now().millisecondsSinceEpoch) {
        // 如果用户设置了过期时间，同时过期时间小于当前时间，则清除旧数据
        localStorage.removeItem(key);
        $value = value.obs;
      } else {
        List listData = localDataModel.data;
        // 如果是基本数据类型，则直接通过cast强转类型返回数据，否则你必须提供序列化和反序列化函数进行转换
        if (isBaseType && deserializeFun == null) {
          $value = listData.cast<T>().obs;
        } else {
          $value = listData.map((value) => deserializeFun!(value)).cast<T>().toList().obs;
        }
      }
    }
    // 列表可能会频繁更新，这里使用节流同步本地数据
    interval(
      $value,
      (v) {
        localStorage.setItem(
          key,
          jsonEncode(
            _LocalDataModel(
              valueType,
              serializeFun == null
                  ? v
                  : v.map((value) {
                      return serializeFun(value);
                    }).toList(),
              expire,
            ).toJson(),
          ),
        );
      },
      time: const Duration(seconds: 1),
    );
    return $value;
  }

  /// 创建[Getx]响应式[Map]，key强制为String，更新时会同步至本地，重新加载时会取本地数据作为初始值
  /// * value - 初始值
  /// * key - 本地缓存key，请确保它们唯一
  ///
  /// * clear - 清除本地缓存，此属性一般用于重置本地数据
  /// * expireFun - 过期时间函数，默认返回-1，表示永不过期，每次更新变量时都会调用此函数
  /// * serializeFun - 序列化函数，如果你传入的是对象，你必须将其转换为字符串才能缓存在本地
  /// * deserializeFun - 反序列化函数，将本地存储的字符串转回目标对象
  ///
  /// 示例：
  /// ```dart
  /// // value为int类型的Map
  /// final localMap = useLocalMapObs<int>({}, 'localMap');
  ///
  /// // value为Model实体对象类型的Map，必须包含序列化方法toJson、fromJson
  /// final userModelMap = useLocalMapObs<UserModel>(
  ///   {},
  ///   'userModelMap',
  ///   serializeFun: (value) => jsonEncode(value.toJson()),
  ///   deserializeFun: (value) => UserModel.fromJson(jsonDecode(value)),
  /// );
  /// ```
  RxMap<String, T> useLocalMapObs<T>(
    Map<String, T> value,
    String key, {
    bool clear = false,
    int expire = -1,
    SerializeFun<T>? serializeFun,
    DeserializeFun<T>? deserializeFun,
  }) {
    if (clear) localStorage.removeItem(key);
    String valueType = T.toString();
    i(valueType);
    bool isBaseType = DartUtil.isBaseTypeString(valueType) || valueType.contains('Map');
    assert(isBaseType || (serializeFun != null && deserializeFun != null), '请为响应式持久化变量[$key]提供序列化和反序列化函数');
    late RxMap<String, T> $value;
    dynamic localData = localStorage.getItem(key);
    if (localData == null) {
      $value = value.obs;
    } else {
      var localDataModel = _LocalDataModel.fromJson(jsonDecode(localData));
      if (localDataModel.type != valueType) {
        // 如果更改了响应式变量类型，则清除旧数据
        localStorage.removeItem(key);
        $value = value.obs;
      } else if (localDataModel.expire! > 0 && localDataModel.expire! < DateTime.now().millisecondsSinceEpoch) {
        // 如果用户设置了过期时间，同时过期时间小于当前时间，则清除旧数据
        localStorage.removeItem(key);
        $value = value.obs;
      } else {
        Map mapData = localDataModel.data;
        // 如果是基本数据类型，则直接通过cast强转类型返回数据，否则你必须提供序列化和反序列化函数进行转换
        if (isBaseType && deserializeFun == null) {
          $value = mapData.cast<String, T>().obs;
        } else {
          $value = mapData.map((key, value) => MapEntry(key, deserializeFun!(value))).cast<String, T>().obs;
        }
      }
    }
    ever($value, (v) {
      localStorage.setItem(
        key,
        jsonEncode(
          _LocalDataModel(
            valueType,
            serializeFun == null ? v : v.map((key, value) => MapEntry(key, serializeFun(value))),
            expire,
          ).toJson(),
        ),
      );
    });
    return $value;
  }
}
