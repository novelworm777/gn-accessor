import 'package:cloud_firestore/cloud_firestore.dart';

import '../../constants/database_collection.dart';
import '../../domain/models/body_index_domain.dart';
import '../../utils/services/firestore.dart';
import '../models/body_index_firestore_data.dart';
import '../../types/variant_doc.dart';

/// Repository for body index [FirebaseFirestore] collection.
class BodyIndexRepository {
  final _firestore = Firestore.user();

  /// Find a body index by [BodyIndexFirestoreData.date].
  Future<BodyIndexDomain?> findOneByDate({
    required String userId,
    required DateTime date,
  }) async {
    final QuerySnapshot<BodyIndexFirestoreData> found =
        await _bodyIndexes(userId: userId)
            .where('date', isGreaterThanOrEqualTo: date)
            .where('date', isLessThan: date.add(const Duration(days: 1)))
            .limit(1)
            .get();
    List<BodyIndexDomain> converted = found.docs
        .map((snapshot) => BodyIndexDomain.fromData(snapshot.data()))
        .toList();
    if (converted.isNotEmpty) return converted.first;
    return null;
  }

  /// Find a variant document.
  Future<BodyIndexDomain> findVariant({
    required String userId,
    required VariantDoc variant,
  }) async {
    final docId = VariantDoc.getDocId(dBodyIndex, variant);
    final snapshot = await _bodyIndexes(userId: userId).doc(docId).get();
    return BodyIndexDomain.fromData(snapshot.data()!);
  }

  /// Delete a body index by [BodyIndexFirestoreData.id].
  void deleteOneById({
    required String userId,
    required String bodyIndexId,
  }) async {
    await _bodyIndexes(userId: userId).doc(bodyIndexId).delete();
  }

  /// Create [FirebaseFirestore] instance for body index collection.
  CollectionReference<BodyIndexFirestoreData> _bodyIndexes(
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
