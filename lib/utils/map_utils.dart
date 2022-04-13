class MapUtils {
  static Map<String, dynamic> clean(Map<String, dynamic> map,
      {List<String>? remove}) {
    // copy map into mutable map
    final newMap = Map.of(map);
    // remove entries with empty value
    newMap.removeWhere((key, value) => value == null || value == '');
    // remove entries by key
    if (remove != null) {
      for (String key in remove) {
        newMap.remove(key);
      }
    }
    return newMap;
  }
}
