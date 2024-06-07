import 'package:localstorage/localstorage.dart';

import 'web.dart' if (dart.library.io) 'io.dart';

bool _initialized = false;
late LocalStorage _sessionStorage;

/// Initialize the [LocalStorage].
Future<void> initSessionStorage() async {
  if (_initialized) return;

  _sessionStorage = await generaInitSessionStorage();
  _initialized = true;
}

/// Get the instance of [sessionStorage].
LocalStorage get sessionStorage => _sessionStorage;
