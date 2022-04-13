import 'package:flutter/foundation.dart';

class User extends ChangeNotifier {
  String? _uid;

  String? get uid => _uid;

  set userData(Map<String, dynamic> user) {
    _uid = user['uid'];
    notifyListeners();
  }
}