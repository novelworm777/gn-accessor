import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gn_accessor/services/user.dart';

class Auth {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<DocumentSnapshot> login({required String uid}) async {
    return await _db.collection(User.collectionName).doc(uid).get();
  }
}
