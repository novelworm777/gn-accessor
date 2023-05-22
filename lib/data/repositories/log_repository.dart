import 'package:cloud_firestore/cloud_firestore.dart';

import '../../constants/database_collection.dart';
import '../../utils/services/firestore.dart';
import '../models/log_firestore_data.dart';

/// Repository for log [FirebaseFirestore] collection.
class LogRepository {
  final _firestore = Firestore.user();

  /// Create [FirebaseFirestore] instance for log collection.
  CollectionReference<LogFirestoreData> _logs({required String userId}) =>
      _firestore.doc(userId).collection(dLog).withConverter<LogFirestoreData>(
            fromFirestore: (snapshot, _) =>
                LogFirestoreData.fromFirestore(snapshot),
            toFirestore: (model, _) => model.toFirestore(),
          );
}
