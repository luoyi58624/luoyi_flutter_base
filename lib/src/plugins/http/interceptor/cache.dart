import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:luoyi_flutter_base/luoyi_flutter_base.dart';

/// 缓存拦截器
class CacheInterceptor extends Interceptor {
  static late String _cacheKey;
  static late int _cacheTime;
  static late bool _showLog;

  static Map<String, Map<String, dynamic>> cacheData = {};

  /// 初始化http本地缓存，已经默认在[initApp]中初始化，如果你需要自定义参数，可以调用此函数再次初始化
  /// * cacheKey 缓存key
  /// * cacheTime 缓存时间
  /// * showLog 是否打印日志
  static Future<void> init({
    String cacheKey = 'http_cache',
    int cacheTime = 1000 * 60 * 60,
    bool showLog = true,
  }) async {
    _cacheKey = cacheKey;
    _cacheTime = cacheTime;
    _showLog = showLog;
    var localStr = localStorage.getItem(_cacheKey);
    if (localStr != null) {
      cacheData = (jsonDecode(localStr) as Map).cast<String, Map<String, dynamic>>();
    }
  }

  /// 清除http缓存数据
  static Future<void> clearCache() async {
    cacheData.clear();
    localStorage.removeItem(_cacheKey);
  }

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    String url = options.uri.toString();
    if (options.extra['useCache'] == true) {
      String key = DartUtil.md5(url);
      if (cacheData[key] == null) {
        handler.next(options);
      } else {
        final modelData = ExpireLocalDataModel.fromJson(cacheData[key]!);
        if (modelData.expire == null || modelData.expire! <= 0 || modelData.expire! > DartUtil.currentMilliseconds) {
          if (_showLog) i(url, '接口缓存');
          if (options.extra['autoCloseLoading'] == true) await LoadingUtil.close();
          handler.resolve(Response(requestOptions: options, data: modelData.data));
        } else {
          handler.next(options);
        }
      }
    } else {
      handler.next(options);
    }
  }

  @override
  onResponse(Response response, ResponseInterceptorHandler handler) async {
    // 判断请求选项是否配置了enableCache，如果为true则将结果保存到本地
    if (response.requestOptions.extra['enableCache'] == true) {
      String key = DartUtil.md5(response.requestOptions.uri.toString());
      cacheData[key] =
          ExpireLocalDataModel(response.data, response.requestOptions.extra['cacheTime'] ?? _cacheTime).toJson();
      localStorage.setItem(
        _cacheKey,
        jsonEncode(cacheData),
      );
    }
    return handler.next(response);
  }
}
