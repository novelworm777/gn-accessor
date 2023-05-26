import '../../data/repositories/diary_repository.dart';
import '../models/diary_domain.dart';

/// Service for diary module.
class DiaryService {
  final DiaryRepository _repository = DiaryRepository();

  /// Create an empty diary.
  Future<DiaryPageDomain> create({required String userId}) async {
    var page = await _createPage(userId: userId);
    var cell = await _createCell(userId: userId, pageId: page.id!);
    return await _addCellToSection(userId: userId, page: page, cell: cell);
  }

  /// Create a diary page.
  Future<DiaryPageDomain> _createPage({required String userId}) async {
    // set attributes
    var now = DateTime.now();
    var newPage = DiaryPageDomain(
      date: DateTime(now.year, now.month, now.day),
      sections: [DiarySectionDomain()],
      isActive: true,
      createdAt: now,
    );
    // create data
    return _repository.createPage(
      userId: userId,
      data: newPage,
    );
  }

  /// Create a diary cell.
  Future<DiaryCellDomain> _createCell({
    required String userId,
    required String pageId,
  }) async {
    // set attributes
    var newCell = DiaryCellDomain(
      isActive: true,
      createdBy: userId,
    );
    // create data
    return await _repository.createCell(
      userId: userId,
      pageId: pageId,
      data: newCell,
    );
  }

  /// Get diary pages (non-archived).
  Future<List<DiaryPageDomain>> getPages({required String userId}) async {
    return await _repository.findAllPageByActive(userId: userId);
  }

  /// Add cell to section.
  Future<DiaryPageDomain> _addCellToSection({
    required String userId,
    required DiaryPageDomain page,
    required DiaryCellDomain cell,
    int sectionIndex = 0,
  }) async {
    // set updated attributes
    page.sections![sectionIndex].cells?.add(cell);
    // update data
    return await _repository.updatePage(
      userId: userId,
      pageId: page.id!,
      data: page,
      merge: true,
    );
  }
}
