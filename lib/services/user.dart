import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

class User extends ChangeNotifier {
  String _uid = '';
  int? _coin;

  String? get uid => _uid;

  set userData(DocumentSnapshot doc) {
    Map<dynamic, dynamic> data = doc.data() as Map;
    _uid = doc.id;
    _coin = data['coin'];
    notifyListeners();
  }
}
