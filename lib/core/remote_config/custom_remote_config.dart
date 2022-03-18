abstract class CustomRemoteConfig {
  Future<void> fetch();

  getValueOrDefault({required String key, required dynamic defaultValue});
}
