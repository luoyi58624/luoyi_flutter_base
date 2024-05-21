part of '../../luoyi_flutter_base.dart';

/// 包含过期时间本地数据模型
class _ExpireLocalDataModel {
  /// 存储的数据
  dynamic data;

  /// 过期时间，单位毫秒，如果为null或者小于等于0，[expire]将强制等于-1，表示没有过期时间，
  int? expire;

  _ExpireLocalDataModel(this.data, [int? expire]) {
    if (expire != null && expire > 0) {
      this.expire = DartUtil.currentMilliseconds + expire;
    } else {
      this.expire = -1;
    }
  }

  _ExpireLocalDataModel.fromJson(Map<String, dynamic> json) {
    data = json['data'];
    expire = json['expire'];
  }

  Map<String, dynamic> toJson() {
    return {
      'data': data,
      'expire': expire,
    };
  }
}
