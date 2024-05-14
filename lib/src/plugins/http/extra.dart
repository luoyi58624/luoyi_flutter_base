import 'package:dio/dio.dart';

class RequestExtra {
  /// 取消请求token，如果未传入，则使用默认的cancelToken
  CancelToken? cancelToken;

  /// 请求进度监听
  ProgressCallback? onReceiveProgress;

  /// 是否显示全局异常消息，如果为true，last_interceptor拦截器将会显示网络错误
  bool? showErrorMessage;

  /// 是否显示服务器接口异常消息，如果为true，注意：此选项需要你自己根据业务去实现，例如判断接口返回的状态码，显示接口返回的错误信息等等...
  bool? showServerException;

  /// 接口请求完成后是否关闭全局loading（必须使用[LoadingUtil]，如果页面没有loading弹窗，则不做任何操作），
  /// 如果你需要执行多个请求，同时又希望它们共用一个Loading弹窗，那么你应该将它设为false。
  ///
  /// 它由某些拦截器控制：[cacheInterceptor]、[errorInterceptor],
  bool? autoCloseLoading;

  /// 强制使用mock数据，注意：你需要在mock文件中声明此接口的数据
  bool? useMockData;

  RequestExtra({
    this.cancelToken,
    this.onReceiveProgress,
    this.showErrorMessage,
    this.showServerException,
    this.autoCloseLoading,
    this.useMockData,
  });
}

class GetRequestExtra extends RequestExtra {
  /// 是否开启缓存，若为true，接口响应成功后数据将会保存于本地，key为url
  bool? enableCache;

  /// 是否使用缓存数据，如果本地存在数据，则直接返回本地数据，不会发送请求，
  /// 你可以在缓存拦截器中自定义缓存时间，如果用户处于无网络状态，则直接响应缓存数据。
  bool? useCache;

  /// 缓存时间，若指定则会覆盖缓存拦截器默认的时间
  int? cacheTime;

  GetRequestExtra({
    super.cancelToken,
    super.onReceiveProgress,
    super.showErrorMessage,
    super.showServerException,
    super.autoCloseLoading,
    this.enableCache,
    this.useCache,
    this.cacheTime,
  });
}

class PostRequestExtra extends RequestExtra {
  /// 监听上传进度
  ProgressCallback? onSendProgress;

  PostRequestExtra({
    super.cancelToken,
    super.onReceiveProgress,
    super.showErrorMessage,
    super.showServerException,
    super.autoCloseLoading,
    this.onSendProgress,
  });
}

class PutRequestExtra extends RequestExtra {
  /// 监听上传进度
  ProgressCallback? onSendProgress;

  PutRequestExtra({
    super.cancelToken,
    super.onReceiveProgress,
    super.showErrorMessage,
    super.showServerException,
    super.autoCloseLoading,
    this.onSendProgress,
  });
}

class PatchRequestExtra extends RequestExtra {
  /// 监听上传进度
  ProgressCallback? onSendProgress;

  PatchRequestExtra({
    super.cancelToken,
    super.onReceiveProgress,
    super.showErrorMessage,
    super.showServerException,
    super.autoCloseLoading,
    this.onSendProgress,
  });
}

class DeleteRequestExtra extends RequestExtra {
  DeleteRequestExtra({
    super.cancelToken,
    super.showErrorMessage,
    super.showServerException,
    super.autoCloseLoading,
  });
}
