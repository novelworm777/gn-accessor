import 'package:flutter/foundation.dart';

/// User presentation model.
class User with ChangeNotifier, DiagnosticableTreeMixin {
  String? _uid;
  int? _cryois;

  /// No-args constructor for [User].
  User();

  /// Set [User] properties from a map.
  set user(Map<String, dynamic> map) {
    _uid = map['uid'] ?? '-';
    _cryois = map['cryois'] ?? -1;
  }

  // getter
  String get uid => _uid!;
  int get cryois => _cryois!;

  /// Makes [User] readable inside devtools.
  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(StringProperty('uid', _uid));
    properties.add(IntProperty('cryois', _cryois));
  }
}
