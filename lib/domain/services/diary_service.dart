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
    return await _repository.createPage(
      userId: userId,
      data: newPage,
    );
  }

  /// Add a new section into diary page.
  Future<DiaryPageDomain> addSection({
    required String userId,
    required String pageId,
  }) async {
    var cell = await _createCell(userId: userId, pageId: pageId);
    return await _createSection(userId: userId, pageId: pageId, cell: cell);
  }

  /// Create a diary section.
  Future<DiaryPageDomain> _createSection({
    required String userId,
    required String pageId,
    required DiaryCellDomain cell,
  }) async {
    // get diary page
    var page = await _getPageById(userId: userId, pageId: pageId);
    // set updated attributes
    var newSection = DiarySectionDomain(cells: [cell]);
    page.sections?.add(newSection);
    page.updatedAt = DateTime.now();
    // update data
    return await _repository.updatePage(
      userId: userId,
      pageId: pageId,
      data: page,
      merge: false,
    );
  }

  /// Add a new cell into diary section.
  Future<DiaryPageDomain> addCell({
    required String userId,
    required String pageId,
    required int sectionIndex,
  }) async {
    var cell = await _createCell(userId: userId, pageId: pageId);
    var page = await _getPageById(userId: userId, pageId: pageId);
    return await _addCellToSection(
      userId: userId,
      page: page,
      cell: cell,
      sectionIndex: sectionIndex,
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

  /// Get diary page by [DiaryPageDomain.id].
  Future<DiaryPageDomain> _getPageById({
    required String userId,
    required String pageId,
  }) async {
    return await _repository.findPage(userId: userId, pageId: pageId);
  }

  /// Change [DiaryPageDomain.date] of a diary page.
  Future<DiaryPageDomain> changePageDate({
    required String userId,
    required String pageId,
    required DateTime date,
  }) async {
    // set updated attributes
    var page = DiaryPageDomain(
      date: DateTime(date.year, date.month, date.day),
      updatedAt: DateTime.now(),
    );
    await _changeCellDateOfTime(userId: userId, pageId: pageId, date: date);
    // update data
    return await _repository.updatePage(
      userId: userId,
      pageId: pageId,
      data: page,
    );
  }

  /// Change [DiaryPageDomain.updatedAt] of a diary page.
  Future<DiaryPageDomain> _setPageUpdateTime({
    required String userId,
    required String pageId,
    DateTime? updatedAt,
  }) async {
    // set updated attributes
    var page = DiaryPageDomain(updatedAt: updatedAt ?? DateTime.now());
    // update data
    return await _repository.updatePage(
      userId: userId,
      pageId: pageId,
      data: page,
    );
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

  /// Change the date in [DiaryCellDomain.time].
  Future<List<DiaryCellDomain>> _changeCellDateOfTime({
    required String userId,
    required String pageId,
    required DateTime date,
  }) async {
    // get diary page
    var page = await _getPageById(userId: userId, pageId: pageId);
    // set updated attributes
    List<DiaryCellDomain> updated = [];
    if (page.sections == null) return [];
    for (var section in page.sections!) {
      if (section.cells == null) continue;
      for (var cell in section.cells!) {
        if (cell.time != null) {
          updated.add(DiaryCellDomain(
            id: cell.id,
            time: DateTime(
              page.date!.year,
              page.date!.month,
              page.date!.day,
              cell.time!.hour,
              cell.time!.minute,
            ),
          ));
        }
      }
    }
    // update data
    return await _repository.updateCells(
      userId: userId,
      pageId: pageId,
      data: updated,
    );
  }

  /// Change [DiaryCellDomain.text] of a diary cell.
  Future<DiaryCellDomain> changeText({
    required String userId,
    required String pageId,
    required int sectionIndex,
    required int cellIndex,
    required String text,
  }) async {
    // set update time of page
    var page = await _setPageUpdateTime(userId: userId, pageId: pageId);
    // set updated attributes
    var cell = DiaryCellDomain(text: text);
    // update data
    var cellId = page.sections![sectionIndex].cells![cellIndex].id;
    return await _repository.updateCell(
      userId: userId,
      pageId: pageId,
      cellId: cellId!,
      data: cell,
    );
  }

  /// Remove a diary section from page.
  Future<DiaryPageDomain> removeSection({
    required String userId,
    required String pageId,
    required int sectionIndex,
  }) async {
    // get page
    var page = await _getPageById(userId: userId, pageId: pageId);
    // set updated attributes
    var section = page.sections!.removeAt(sectionIndex);
    page.updatedAt = DateTime.now();
    // delete cell data
    for (var cell in section.cells!) {
      _deleteCell(userId: userId, pageId: pageId, cellId: cell.id!);
    }
    // update page data
    return await _repository.updatePage(
      userId: userId,
      pageId: pageId,
      data: page,
      merge: false,
    );
  }

  /// Remove a diary cell from section.
  Future<DiaryPageDomain> removeCell({
    required String userId,
    required String pageId,
    required int sectionIndex,
    required int cellIndex,
  }) async {
    // get page
    var page = await _getPageById(userId: userId, pageId: pageId);
    // set updated attributes
    var cell = page.sections![sectionIndex].cells!.removeAt(cellIndex);
    page.updatedAt = DateTime.now();
    // delete cell data
    _deleteCell(userId: userId, pageId: pageId, cellId: cell.id!);
    // update page data
    return await _repository.updatePage(
      userId: userId,
      pageId: pageId,
      data: page,
      merge: false,
    );
  }

  /// Delete a diary cell.
  void _deleteCell({
    required String userId,
    required String pageId,
    required String cellId,
  }) async {
    // delete data
    return _repository.deleteCell(
      userId: userId,
      pageId: pageId,
      cellId: cellId,
    );
  }
}
