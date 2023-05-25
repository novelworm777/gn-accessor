import '../../data/repositories/diary_repository.dart';
import '../models/data_transfer_object.dart';
import '../models/diary_domain.dart';

/// Service for diary module.
class DiaryService {
  final DiaryRepository _repository = DiaryRepository();

  /// Create a diary page.
  Future<DiaryPageDomain> create({required String userId}) async {
    // set attributes
    DateTime now = DateTime.now();
    DiaryPageDomain newPage = DiaryPageDomain(
      date: DateTime(now.year, now.month, now.day),
      sections: [
        DiarySectionDomain(cells: [DiaryCellDomain()])
      ],
      isActive: true,
      createdAt: now,
    );
    // create data
    return _repository.createOne(
      userId: userId,
      data: newPage,
    );
  }

  /// Get diary pages (non-archived).
  Future<List<DiaryPageDomain>> getPages({required String userId}) async {
    Where where = const Where(field: 'is_active', value: true);
    OrderBy orderBy = const OrderBy(field: 'date', isAscending: false);
    return await _repository.findAllWhereEqualTo(
      userId: userId,
      where: where,
      orderBy: orderBy,
    );
  }
}
