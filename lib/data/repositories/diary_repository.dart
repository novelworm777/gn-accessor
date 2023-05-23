import 'package:cloud_firestore/cloud_firestore.dart';

import '../../constants/database_collection.dart';
import '../../utils/services/firestore.dart';
import '../models/diary_firestore_data.dart';

/// Repository for diary [FirebaseFirestore] collection.
class DiaryRepository {
  final _firestore = Firestore.user();

  /// Create [FirebaseFirestore] instance for diary collection.
  CollectionReference<DiaryPageFirestoreData> _diaries(
          {required String userId}) =>
      _firestore
          .doc(userId)
          .collection(dDiary)
          .withConverter<DiaryPageFirestoreData>(
            fromFirestore: (snapshot, _) =>
                DiaryPageFirestoreData.fromFirestore(snapshot),
            toFirestore: (model, _) => model.toFirestore(),
          );
}
