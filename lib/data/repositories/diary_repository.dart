import 'package:cloud_firestore/cloud_firestore.dart';

import '../../constants/database_collection.dart';
import '../../domain/models/data_transfer_object.dart';
import '../../domain/models/diary_domain.dart';
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

  /// Create a diary page data.
  Future<DiaryPageDomain> createOne({
    required String userId,
    required DiaryPageDomain data,
  }) async {
    final converted = DiaryPageFirestoreData.fromDomain(data);
    final created = await _diaries(userId: userId).add(converted).then(
          (snapshot) => snapshot.get(),
          onError: (error) =>
              throw FormatException("failed to create diary page: $error"),
        );
    return DiaryPageDomain.fromData(created.data()!);
  }

  /// Find all diary page data.
  Future<List<DiaryPageDomain>> findAllWhereEqualTo({
    required String userId,
    required Where where,
    OrderBy orderBy = const OrderBy(),
  }) async {
    late QuerySnapshot<DiaryPageFirestoreData> found;
    // use default order by of firestore
    if (orderBy.field == 'id') {
      found = await _diaries(userId: userId)
          .where(where.field, isEqualTo: where.value)
          .get();
    }
    // use assigned order by
    else {
      found = await _diaries(userId: userId)
          .where(where.field, isEqualTo: where.value)
          .orderBy(orderBy.field, descending: !orderBy.isAscending)
          .get();
    }
    return found.docs
        .map((snapshot) => DiaryPageDomain.fromData(snapshot.data()))
        .toList();
  }
}
