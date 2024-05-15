part of '../../../luoyi_flutter_base.dart';

bool _initialized = false;
late LocalStorage _sessionStorage;

/// Initialize the [LocalStorage].
Future<void> initSessionStorage() async {
  if (_initialized) return;

  _sessionStorage = await generaInitSessionStorage();
  _initialized = true;
}

/// Get the instance of [LocalStorage].
LocalStorage get sessionStorage => _sessionStorage;
