import 'package:cloud_firestore/cloud_firestore.dart';

import '../constants/database_collection.dart';
import '../domain/models/user.dart';

class UserRepository {
  /// Find all user data.
  Future<List<User>> findAllWhereEqualTo({
    required String field,
    required dynamic value,
  }) async {
    QuerySnapshot<Map<String, dynamic>> found =
        await _users().where(field, isEqualTo: value).get();
    return found.docs
        .map<User>((doc) => User.create(doc.id, doc.data()))
        .toList();
  }

  Future<User?> findUser(String docId) async {
    DocumentSnapshot<Map<String, dynamic>> doc =
        await _users().doc(docId).get();
    if (doc.exists) return User.create(doc.id, doc.data()!);
    return null;
  }

  /// Update a user data.
  ///
  /// Only the data given will be updated, others will be untouched.
  void updateOne({
    required String userId,
    required Map<String, dynamic> data,
  }) =>
      _users().doc(userId).update(data);

  /// Create [FirebaseFirestore] instance for user collection.
  CollectionReference<Map<String, dynamic>> _users() =>
      FirebaseFirestore.instance.collection(dUser);
}
