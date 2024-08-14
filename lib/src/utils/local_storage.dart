import 'package:shared_preferences/shared_preferences.dart';

SharedPreferences? _localStorage;

/// 本地存储实例，基于 Flutter 官方实现的 [SharedPreferences]
SharedPreferences get localStorage {
  assert(_localStorage != null,
      'localStorage 还未初始化，请在 main 函数中执行 initLocalStorage 方法');
  return _localStorage!;
}

/// 初始化本地存储实例
Future<void> initLocalStorage() async {
  _localStorage = await SharedPreferences.getInstance();
}
