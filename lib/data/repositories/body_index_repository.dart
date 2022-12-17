import 'package:cloud_firestore/cloud_firestore.dart';

import '../../constants/database_collection.dart';
import '../../domain/models/body_index_domain.dart';
import '../../utils/services/firestore.dart';
import '../models/body_index_firestore_data.dart';

/// Repository for body index [FirebaseFirestore] collection.
class BodyIndexRepository {
  final _firestore = Firestore.user();

  /// Find a body index by [BodyIndexFirestoreData.date].
  Future<BodyIndexDomain?> findOneByDate({
    required String userId,
    required DateTime fieldValue,
  }) async {
    final QuerySnapshot<BodyIndexFirestoreData> found =
        await _records(userId: userId)
            .where('date', isGreaterThanOrEqualTo: fieldValue)
            .where('date', isLessThan: fieldValue.add(const Duration(days: 1)))
            .limit(1)
            .get();
    List<BodyIndexDomain> converted = found.docs
        .map((snapshot) => BodyIndexDomain.fromData(snapshot.data()))
        .toList();
    if (converted.isNotEmpty) return converted.first;
    return null;
  }

  /// Create [FirebaseFirestore] instance for body index collection.
  CollectionReference<BodyIndexFirestoreData> _records(
          {required String userId}) =>
      _firestore
          .doc(userId)
          .collection(dBodyIndex)
          .withConverter<BodyIndexFirestoreData>(
            fromFirestore: ((snapshot, _) =>
                BodyIndexFirestoreData.fromFirestore(snapshot)),
            toFirestore: (model, _) => model.toFirestore(),
          );
}
