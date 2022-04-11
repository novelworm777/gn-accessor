import 'package:cloud_firestore/cloud_firestore.dart';

class TaskBoard {
  static const String _collectionName = 'tasks';

  final CollectionReference<Map<String, dynamic>> _db =
      FirebaseFirestore.instance.collection('users');

  Stream<QuerySnapshot<Map<String, dynamic>>> getTasks(String uid) {
    return _db
        .doc(uid)
        .collection(_collectionName)
        .orderBy('created_at', descending: false)
        .snapshots();
  }
}
