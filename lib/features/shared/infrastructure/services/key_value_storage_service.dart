abstract class KeyValueStorageService{
  Future<void> setKeyValue(String key, dynamic value);
  Future<void> getValue(String key);
  Future<void> removeKey(String key);
}
