import 'package:cloud_firestore/cloud_firestore.dart';

import '../../constants/database_collection.dart';
import '../domain/models/user.dart';

class UserRepository {
  Future<User?> findUser(String docId) async {
    DocumentSnapshot<Map<String, dynamic>> doc = await _db().doc(docId).get();
    if (doc.exists) return User.create(doc.id, doc.data()!);
    return null;
  }

  CollectionReference<Map<String, dynamic>> _db() =>
      FirebaseFirestore.instance.collection(dUser);
}
