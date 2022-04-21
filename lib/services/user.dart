import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

class User extends ChangeNotifier {
  static const String collectionName = 'users';

  String _uid = '';
  int _cryois = 0;

  String get uid => _uid;
  int get cryois => _cryois;

  final CollectionReference<Map<String, dynamic>> _db =
      FirebaseFirestore.instance.collection(collectionName);

  set userData(DocumentSnapshot doc) {
    Map<dynamic, dynamic> data = doc.data() as Map;
    _uid = doc.id;
    _cryois = data['cryois'];
    notifyListeners();
  }

  /// Increase the amount of cryois.
  void increaseCryois(int added) {
    _cryois = _cryois + added;
    _db.doc(_uid).update({'coin': _cryois + added});
    notifyListeners();
  }
}
