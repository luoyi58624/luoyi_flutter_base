import 'package:luoyi_dart_base/luoyi_dart_base.dart';

/// 数据模型序列化，一般用于本地持久化缓存
/// ```dart
/// class UserModel extends ModelSerialize {
///   UserModel({this.name, this.age});
///
///   String? name;
///   int? age;
///
///   factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
///         name: json['name'],
///         age: DartUtil.safeInt(json['age']),
///       );
///
///   @override
///   UserModel fromJson(Map<String, dynamic> json) => UserModel.fromJson(json);
///
///   @override
///   Map<String, dynamic> toJson() => {'name': name, 'age': age};
/// }
/// ```
abstract class ModelSerialize {
  ModelSerialize fromJson(Map<String, dynamic> json);

  Map<String, dynamic> toJson();
}

/// 包含过期时间本地数据模型
class ExpireLocalDataModel extends ModelSerialize {
  /// 存储的数据
  dynamic data;

  /// 过期时间，单位毫秒，如果为null或者小于等于0，[expire]将强制等于-1，表示没有过期时间，
  int? expire;

  ExpireLocalDataModel(this.data, [int? expire]) {
    if (expire != null && expire > 0) {
      this.expire = currentMilliseconds + expire;
    } else {
      this.expire = -1;
    }
  }

  ExpireLocalDataModel.fromJson(Map<String, dynamic> json) {
    data = json['data'];
    expire = json['expire'];
  }

  @override
  ModelSerialize fromJson(Map<String, dynamic> json) => ExpireLocalDataModel.fromJson(json);

  @override
  Map<String, dynamic> toJson() => {'data': data, 'expire': expire};
}
