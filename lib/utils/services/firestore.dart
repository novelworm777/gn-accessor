import 'package:cloud_firestore/cloud_firestore.dart';

import '../../constants/database_collection.dart';

/// [FirebaseFirestore] basic instances.
class Firestore {
  /// Get instance for user collection.
  static CollectionReference<Map<String, dynamic>> user() =>
      FirebaseFirestore.instance.collection(dUser);
}
