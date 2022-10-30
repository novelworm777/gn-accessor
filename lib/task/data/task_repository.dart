import 'package:cloud_firestore/cloud_firestore.dart';

import '../../constants/database_collection.dart';

class TaskRepository {
  /// Create [FirebaseFirestore] instance.
  CollectionReference<Map<String, dynamic>> _db(String userId) =>
      FirebaseFirestore.instance
          .collection(dUser)
          .doc(userId)
          .collection(dTask);
}
