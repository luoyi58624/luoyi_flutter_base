part of '../../luoyi_flutter_base.dart';

/// 包含name-icon结构的简单数据模型
class IconModel {
  IconModel(this.name, this.icon);

  final String name;
  final IconData icon;
}

/// 导航模型抽象类
class NavModel {
  NavModel(this.title, {this.icon});

  /// 导航的标题名字
  late String title;

  /// 导航图标，可选
  IconData? icon;
}

/// 命令式导航页面模型
class PageNavModel extends NavModel {
  PageNavModel(super.title, this.page, {super.icon});

  Widget page;
}

/// 声明式导航页面模型
class UrlNavModel extends NavModel {
  UrlNavModel(super.title, this.path, {super.icon});

  late String path;
}

/// 包含过期时间本地数据模型
class ExpireLocalDataModel {
  /// 存储的数据
  dynamic data;

  /// 过期时间，单位毫秒，如果为null或者小于等于0，则表示没有过期时间
  /// 示例：
  /// * 30分钟后过期：DateTime.now().millisecondsSinceEpoch + 1000 * 60 * 30
  /// * 2024年1月1日过期：DateTime(2024, 1, 1).millisecondsSinceEpoch
  int? expire;

  ExpireLocalDataModel(this.data, [this.expire]);

  ExpireLocalDataModel.fromJson(Map<String, dynamic> json) {
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
