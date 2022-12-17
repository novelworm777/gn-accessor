/// Utility class to format a map.
class MapFormatter {
  /// Remove entries with null value.
  static Map<String, dynamic> removeNull(Map<String, dynamic> map) {
    final newMap = Map.of(map);
    newMap.removeWhere((key, value) => value == null);
    return newMap;
  }
}
