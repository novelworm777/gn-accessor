import 'package:flutter/foundation.dart';

/// User presentation model.
class User with ChangeNotifier, DiagnosticableTreeMixin {
  String? _id;

  /// No-args constructor for [User].
  User();

  /// Set [User] properties from a map.
  set user(Map<String, dynamic> map) {
    _id = map['id'] ?? 'userId';
  }

  // getter
  String get id => _id!;

  /// Makes [User] readable inside devtools.
  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(StringProperty('id', _id));
  }
}
