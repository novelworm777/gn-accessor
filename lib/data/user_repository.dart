import 'package:cloud_firestore/cloud_firestore.dart';

import '../constants/database_collection.dart';
import '../domain/models/user.dart';

class UserRepository {
  Future<User?> findUser(String docId) async {
    DocumentSnapshot<Map<String, dynamic>> doc =
        await _firestore().doc(docId).get();
    if (doc.exists) return User.create(doc.id, doc.data()!);
    return null;
  }

  /// Update a user data.
  ///
  /// Only the data given will be updated, others will be untouched.
  void updateOne(
          {required String userId, required Map<String, dynamic> data}) =>
      _firestore(userId: userId).update(data);

  _firestore({String? userId}) {
    if (userId != null) {
      return FirebaseFirestore.instance.collection(dUser).doc(userId);
    }
    return FirebaseFirestore.instance.collection(dUser);
  }
}
