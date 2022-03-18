import 'package:firebase_remote_config/firebase_remote_config.dart';

import 'custom_remote_config.dart';

class CustomRemoteConfigImpl implements CustomRemoteConfig {
  late FirebaseRemoteConfig _firebaseRemoteConfig;

  CustomRemoteConfigImpl._internal();
  static final CustomRemoteConfigImpl _customRemoteConfig =
      CustomRemoteConfigImpl._internal();
  factory CustomRemoteConfigImpl() => _customRemoteConfig;

  Future<void> init() async {
    _firebaseRemoteConfig = FirebaseRemoteConfig.instance;
    await _firebaseRemoteConfig.setConfigSettings(
      RemoteConfigSettings(
        fetchTimeout: const Duration(seconds: 10),
        minimumFetchInterval: const Duration(hours: 2),
      ),
    );
    await _firebaseRemoteConfig.fetchAndActivate();
  }

  @override
  Future<void> fetch() async {
    _firebaseRemoteConfig = FirebaseRemoteConfig.instance;
    await _firebaseRemoteConfig.setConfigSettings(
      RemoteConfigSettings(
        fetchTimeout: const Duration(seconds: 10),
        minimumFetchInterval: Duration.zero,
      ),
    );
    await _firebaseRemoteConfig.fetchAndActivate();
  }

  @override
  getValueOrDefault({required String key, required dynamic defaultValue}) {
    switch (defaultValue.runtimeType) {
      case String:
        String _value = _firebaseRemoteConfig.getString(key);
        return _value != '' ? _value : defaultValue;
      case int:
        int _value = _firebaseRemoteConfig.getInt(key);
        return _value != 0 ? _value : defaultValue;
      case bool:
        bool _value = _firebaseRemoteConfig.getBool(key);
        return _value ? _value : defaultValue;
    }
  }
}
