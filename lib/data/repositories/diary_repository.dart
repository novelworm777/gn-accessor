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
  CollectionReference<DiaryPageFirestoreData> _pages(
          {required String userId}) =>
      _firestore
          .doc(userId)
          .collection(dDiary)
          .withConverter<DiaryPageFirestoreData>(
            fromFirestore: (snapshot, _) =>
                DiaryPageFirestoreData.fromFirestore(snapshot),
            toFirestore: (model, _) => model.toFirestore(),
          );

  /// Create [FirebaseFirestore] instance for diary cell collection.
  CollectionReference<DiaryCellFirestoreData> _cells({
    required String userId,
    required String pageId,
  }) =>
      _firestore
          .doc(userId)
          .collection(dDiary)
          .doc(pageId)
          .collection(dCell)
          .withConverter<DiaryCellFirestoreData>(
            fromFirestore: (snapshot, _) =>
                DiaryCellFirestoreData.fromFirestore(snapshot),
            toFirestore: (model, _) => model.toFirestore(),
          );

  /// Create collection group query for diary cell collections.
  Query<DiaryCellFirestoreData> _groupCellQuery() => FirebaseFirestore.instance
      .collectionGroup(dCell)
      .withConverter<DiaryCellFirestoreData>(
        fromFirestore: (snapshot, _) =>
            DiaryCellFirestoreData.fromFirestore(snapshot),
        toFirestore: (model, _) => model.toFirestore(),
      );

  /// Create a diary page data.
  Future<DiaryPageDomain> createPage({
    required String userId,
    required DiaryPageDomain data,
  }) async {
    final converted = DiaryPageFirestoreData.fromDomain(data);
    final created = await _pages(userId: userId).add(converted).then(
          (snapshot) => snapshot.get(),
          onError: (error) =>
              throw FormatException("failed to create diary page: $error"),
        );
    final cells = await findAllCellByCreator(userId: userId);
    return DiaryPageDomain.fromData(created.data()!, cells);
  }

  /// Create a diary cell data.
  Future<DiaryCellDomain> createCell({
    required String userId,
    required String pageId,
    required DiaryCellDomain data,
  }) async {
    final converted = DiaryCellFirestoreData.fromDomain(data);
    final created =
        await _cells(userId: userId, pageId: pageId).add(converted).then(
              (snapshot) => snapshot.get(),
              onError: (error) =>
                  throw FormatException("failed to create diary cell: $error"),
            );
    return DiaryCellDomain.fromData(created.data()!);
  }

  /// Find all diary page data.
  Future<List<DiaryPageDomain>> findAllPageWhereEqualTo({
    required String userId,
    required Where where,
    OrderBy orderBy = const OrderBy(),
  }) async {
    late QuerySnapshot<DiaryPageFirestoreData> found;

    if (orderBy.field == 'id') {
      found = await _pages(userId: userId)
          .where(where.field, isEqualTo: where.value)
          .get();
    } else {
      found = await _pages(userId: userId)
          .where(where.field, isEqualTo: where.value)
          .orderBy(orderBy.field, descending: !orderBy.isAscending)
          .get();
    }

    final cells = await findAllCellByCreator(userId: userId);
    return found.docs
        .map((snapshot) => DiaryPageDomain.fromData(snapshot.data(), cells))
        .toList();
  }

  /// Find all diary page data according to their active status.
  Future<List<DiaryPageDomain>> findAllPageByActive(
      {required String userId}) async {
    const where = Where(field: 'is_active', value: true);
    const orderBy = OrderBy(field: 'date', isAscending: false);
    return await findAllPageWhereEqualTo(
      userId: userId,
      where: where,
      orderBy: orderBy,
    );
  }

  /// Find all diary cell data according to their creator.
  Future<List<DiaryCellDomain>> findAllCellByCreator(
      {required String userId}) async {
    final found =
        await _groupCellQuery().where('created_by', isEqualTo: userId).get();
    return found.docs
        .map((snapshot) => DiaryCellDomain.fromData(snapshot.data()))
        .toList();
  }

  /// Find a diary page data.
  Future<DiaryPageDomain> findPage({
    required String userId,
    required String pageId,
  }) async {
    final cells = await findAllCellByCreator(userId: userId);
    return await _pages(userId: userId).doc(pageId).get().then(
          (snapshot) => DiaryPageDomain.fromData(snapshot.data()!, cells),
          onError: (error) => null,
        );
  }

  /// Find a diary cell data.
  Future<DiaryCellDomain> findCell({
    required String userId,
    required String pageId,
    required String cellId,
  }) async {
    return await _cells(userId: userId, pageId: pageId).doc(cellId).get().then(
          (snapshot) => DiaryCellDomain.fromData(snapshot.data()!),
          onError: (error) => null,
        );
  }

  /// Update a diary page data.
  Future<DiaryPageDomain> updatePage({
    required String userId,
    required String pageId,
    required DiaryPageDomain data,
    bool merge = true,
  }) async {
    final converted = DiaryPageFirestoreData.fromDomain(data);
    await _pages(userId: userId).doc(pageId).set(
          converted,
          SetOptions(merge: merge),
        );
    return await findPage(
      userId: userId,
      pageId: pageId,
    );
  }

  /// Update multiple diary cell data.
  Future<List<DiaryCellDomain>> updateCells({
    required String userId,
    required String pageId,
    required List<DiaryCellDomain> data,
  }) async {
    List<DiaryCellDomain> updatedList = [];
    for (final cell in data) {
      final updated = await updateCell(
        userId: userId,
        pageId: pageId,
        cellId: cell.id!,
        data: cell,
      );
      updatedList.add(updated);
    }
    return updatedList;
  }

  /// Update a diary cell data.
  Future<DiaryCellDomain> updateCell({
    required String userId,
    required String pageId,
    required String cellId,
    required DiaryCellDomain data,
    bool merge = true,
  }) async {
    final converted = DiaryCellFirestoreData.fromDomain(data);
    await _cells(userId: userId, pageId: pageId).doc(cellId).set(
          converted,
          SetOptions(merge: merge),
        );
    return findCell(userId: userId, pageId: pageId, cellId: cellId);
  }

  /// Delete a diary cell data.
  void deleteCell({
    required String userId,
    required String pageId,
    required String cellId,
  }) async {
    await _cells(userId: userId, pageId: pageId).doc(cellId).delete();
  }
}
