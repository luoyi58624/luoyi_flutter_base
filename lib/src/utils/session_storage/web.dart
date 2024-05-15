import 'package:localstorage/localstorage.dart';
import 'package:web/web.dart';

Future<LocalStorage> generaInitSessionStorage() async {
  return LocalStorageImpl();
}

final class LocalStorageImpl implements LocalStorage {
  @override
  int get length => window.sessionStorage.length;

  @override
  void clear() => window.sessionStorage.clear();

  @override
  String? getItem(String key) => window.sessionStorage[key];

  @override
  String? key(int index) => window.sessionStorage.key(index);

  @override
  void removeItem(String key) => window.sessionStorage.removeItem(key);

  @override
  void setItem(String key, String value) {
    window.sessionStorage[key] = value;
  }
}
