import 'package:dio/dio.dart';
import 'package:luoyi_dart_base/luoyi_dart_base.dart';
import 'package:mini_getx/mini_getx.dart';

import 'extra.dart';
import 'interceptor/error.dart';
import 'interceptor/retry.dart';

export 'extra.dart';
export 'interceptor/error.dart';
export 'interceptor/retry.dart';

/// Http请求类，包含重试请求、错误拦截、请求缓存、数据mock拦截等功能。
/// 扩展示例：
/// ```dart
/// class Http extends FlutterHttp {
///   Http() {
///     // 设置服务接口地址
///     instance.options.baseUrl = 'https://jsonplaceholder.typicode.com';
///     // 自定义拦截器
///     instance.interceptors
///     ..add(BaseHttp.retryInterceptor(instance))
///     ..add(BaseHttp.errorInterceptor());
///   }
///
///   /// 自定义响应模型
///   @override
///   Future<ResponseModel> get(
///     String url, {
///     Object? data,
///     Map<String, dynamic>? params,
///     Options? options,
///     GetRequestExtra? getRequestExtra,
///   }) async {
///     // 复用BaseHttp的逻辑
///     var data = await super.get(url, data: data, params: params, options: options, getRequestExtra: getRequestExtra);
///     // 获得响应数据将其转换成自定义模型
///     return ResponseModel.fromJson(data);
///   }
/// }
///   @override
///   Future<ResponseModel> post(
///     String url, {
///     Object? data,
///     Map<String, dynamic>? params,
///     Options? options,
///     PostRequestExtra? postRequestExtra,
///   }) async {
///     // 复用BaseHttp的逻辑
///     var resData = await super.post(url, data: data, params: params, options: options, postRequestExtra: postRequestExtra);
///     // 获得响应数据将其转换成自定义模型
///     return ResponseModel.fromJson(resData);
///   }
/// ```
class FlutterHttp {
  /// Flutter Http请求构造函数
  /// * enableRetryInterceptor 开启重试拦截器
  /// * enableCacheInterceptor 开启缓存拦截器
  /// * enableErrorInterceptor 开启错误拦截器
  ///
  /// 注意：添加自定义拦截器时请把控好顺序，因为有些拦截器已经处理掉了结果，后面的拦截器就无法再执行，当前最佳拦截器的顺序就是：
  /// retryInterceptor -> CacheInterceptor -> 自定义拦截器 -> ErrorInterceptor
  FlutterHttp({
    enableRetryInterceptor = false,
    enableCacheInterceptor = false,
    enableErrorInterceptor = false,
  }) {
    instance = Dio(baseOptions);
    instance.interceptors
      ..addIf(enableErrorInterceptor, retryInterceptor(instance))
      // ..addIf(enableCacheInterceptor, CacheInterceptor())
      ..addIf(enableErrorInterceptor, ErrorInterceptor());
  }

  /// http请求实例，基于[Dio]
  late final Dio instance;

  /// 基础服务接口地址
  String get baseUrl => '';

  /// 请求超时时间
  int get timeout => DartUtil.isRelease ? 30000 : 5000;

  /// 当启用错误拦截器时，是否默认在屏幕上显示错误信息
  bool get showErrorMessage => true;

  /// 当启用缓存拦截器时，是否默认开启缓存（仅限Get请求）
  bool get enableCache => false;

  /// 当启用缓存拦截器时，是否默认使用缓存（仅限Get请求）
  bool get useCache => false;

  /// 缓存时间，默认1小时
  int get cacheTime => 1000 * 60 * 60;

  /// 当请求结束时是否自动关闭页面上的Loading
  bool get autoCloseLoading => false;

  /// 请求基本配置
  BaseOptions get baseOptions => BaseOptions(
        baseUrl: baseUrl,
        // 连接服务器超时时间
        connectTimeout: Duration(milliseconds: timeout),
        // 两次数据流数据接收的最长间隔时间
        receiveTimeout: Duration(milliseconds: timeout),
      );

  /// Get 请求
  /// * url 请求地址
  /// * data json数据
  /// * params 地址拼接的参数
  /// * options 请求配置
  /// * getRequestExtra get请求额外配置参数
  Future<dynamic> get(
    String url, {
    Object? data,
    Map<String, dynamic>? params,
    Options? options,
    GetRequestExtra? getRequestExtra,
  }) async {
    Options requestOptions;
    if (options != null) {
      options.extra ??= {};
      requestOptions = options;
    } else {
      requestOptions = Options(extra: {});
    }
    getRequestExtra ??= GetRequestExtra();
    requestOptions.extra!['apiUrl'] = url;
    requestOptions.extra!['showErrorMessage'] = getRequestExtra.showErrorMessage ?? showErrorMessage;
    requestOptions.extra!['closeLoading'] = getRequestExtra.closeLoading ?? autoCloseLoading;
    requestOptions.extra!['enableCache'] = getRequestExtra.enableCache ?? enableCache;
    requestOptions.extra!['useCache'] = getRequestExtra.useCache ?? useCache;
    requestOptions.extra!['cacheTime'] = getRequestExtra.cacheTime ?? cacheTime;
    requestOptions.extra!['useMockData'] = getRequestExtra.useMockData;

    try {
      var res = await instance.get(
        url,
        data: data,
        queryParameters: params,
        options: requestOptions,
        cancelToken: getRequestExtra.cancelToken,
        onReceiveProgress: getRequestExtra.onReceiveProgress,
      );
      return res.data;
    } catch (e) {
      rethrow;
    }
  }

  /// Post 请求
  /// * url 请求地址
  /// * data json数据
  /// * params 地址拼接的参数
  /// * options 请求配置
  /// * postRequestExtra post请求额外配置参数
  Future<dynamic> post(
    String url, {
    Object? data,
    Map<String, dynamic>? params,
    Options? options,
    PostRequestExtra? postRequestExtra,
  }) async {
    Options requestOptions;
    if (options != null) {
      options.extra ??= {};
      requestOptions = options;
    } else {
      requestOptions = Options(extra: {});
    }
    postRequestExtra ??= PostRequestExtra();
    requestOptions.extra!['apiUrl'] = url;
    requestOptions.extra!['showErrorMessage'] = postRequestExtra.showErrorMessage;
    requestOptions.extra!['showServerException'] = postRequestExtra.showServerException;
    requestOptions.extra!['closeLoading'] = postRequestExtra.closeLoading;
    requestOptions.extra!['useMockData'] = postRequestExtra.useMockData;
    try {
      var res = await instance.post(
        url,
        data: data,
        queryParameters: params,
        options: requestOptions,
        cancelToken: postRequestExtra.cancelToken,
        onSendProgress: postRequestExtra.onSendProgress,
        onReceiveProgress: postRequestExtra.onReceiveProgress,
      );
      return res.data;
    } catch (e) {
      rethrow;
    }
  }

  /// Put 请求
  /// * url 请求地址
  /// * data json数据
  /// * params 地址拼接的参数
  /// * options 请求配置
  /// * putRequestExtra put请求额外配置参数
  Future<dynamic> put(
    String url, {
    Object? data,
    Map<String, dynamic>? params,
    Options? options,
    PutRequestExtra? putRequestExtra,
  }) async {
    Options requestOptions;
    if (options != null) {
      options.extra ??= {};
      requestOptions = options;
    } else {
      requestOptions = Options(extra: {});
    }
    putRequestExtra ??= PutRequestExtra();
    requestOptions.extra!['apiUrl'] = url;
    requestOptions.extra!['showErrorMessage'] = putRequestExtra.showErrorMessage;
    requestOptions.extra!['showServerException'] = putRequestExtra.showServerException;
    requestOptions.extra!['closeLoading'] = putRequestExtra.closeLoading;
    requestOptions.extra!['useMockData'] = putRequestExtra.useMockData;
    try {
      var res = await instance.put(
        url,
        data: data,
        queryParameters: params,
        options: requestOptions,
        cancelToken: putRequestExtra.cancelToken,
        onSendProgress: putRequestExtra.onSendProgress,
        onReceiveProgress: putRequestExtra.onReceiveProgress,
      );
      return res.data;
    } catch (e) {
      rethrow;
    }
  }

  /// Patch 请求
  /// * url 请求地址
  /// * data json数据
  /// * params 地址拼接的参数
  /// * options 请求配置
  /// * patchRequestExtra patch请求额外配置参数
  Future<dynamic> patch(
    String url, {
    Object? data,
    Map<String, dynamic>? params,
    Options? options,
    PatchRequestExtra? patchRequestExtra,
  }) async {
    Options requestOptions;
    if (options != null) {
      options.extra ??= {};
      requestOptions = options;
    } else {
      requestOptions = Options(extra: {});
    }
    patchRequestExtra ??= PatchRequestExtra();
    requestOptions.extra!['apiUrl'] = url;
    requestOptions.extra!['showErrorMessage'] = patchRequestExtra.showErrorMessage;
    requestOptions.extra!['showServerException'] = patchRequestExtra.showServerException;
    requestOptions.extra!['closeLoading'] = patchRequestExtra.closeLoading;
    requestOptions.extra!['useMockData'] = patchRequestExtra.useMockData;
    try {
      var res = await instance.patch(
        url,
        data: data,
        queryParameters: params,
        options: requestOptions,
        cancelToken: patchRequestExtra.cancelToken,
        onSendProgress: patchRequestExtra.onSendProgress,
        onReceiveProgress: patchRequestExtra.onReceiveProgress,
      );
      return res.data;
    } catch (e) {
      rethrow;
    }
  }

  /// Delete 请求
  /// * url 请求地址
  /// * data json数据
  /// * params 地址拼接的参数
  /// * options 请求配置
  /// * deleteRequestExtra delete请求额外配置参数
  Future<dynamic> delete(
    String url, {
    Object? data,
    Map<String, dynamic>? params,
    Options? options,
    DeleteRequestExtra? deleteRequestExtra,
  }) async {
    Options requestOptions;
    if (options != null) {
      options.extra ??= {};
      requestOptions = options;
    } else {
      requestOptions = Options(extra: {});
    }
    deleteRequestExtra ??= DeleteRequestExtra();
    requestOptions.extra!['apiUrl'] = url;
    requestOptions.extra!['showErrorMessage'] = deleteRequestExtra.showErrorMessage;
    requestOptions.extra!['showServerException'] = deleteRequestExtra.showServerException;
    requestOptions.extra!['closeLoading'] = deleteRequestExtra.closeLoading;
    requestOptions.extra!['useMockData'] = deleteRequestExtra.useMockData;
    try {
      var res = await instance.delete(
        url,
        data: data,
        queryParameters: params,
        options: requestOptions,
        cancelToken: deleteRequestExtra.cancelToken,
      );
      return res.data;
    } catch (e) {
      rethrow;
    }
  }
}
