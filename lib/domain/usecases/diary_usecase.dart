import '../services/diary_service.dart';
import '../services/log_service.dart';

/// Usecase for diary module.
class DiaryUsecase {
  final DiaryService _diaryService = DiaryService();
  final LogService _logService = LogService();

  /// Create a diary page.
  Future<Map<String, dynamic>> createDiaryPage({required String userId}) async {
    // create new diary page
    final page = await _diaryService.create(userId: userId);
    // create new log
    await _logService.createDiaryPage(userId: userId, pageId: page.id!);
    // return as map
    return {
      'id': page.id,
      'date': page.date,
      'sections': page.sections
          ?.map((section) => {
                'title': section.title,
                'cells': section.cells
                    ?.map((cell) => {
                          'time': cell.time,
                          'text': cell.text,
                          'tags': cell.tags,
                        })
                    .toList(),
              })
          .toList(),
    };
  }

  /// Get all diary pages for user diary.
  Future<List<Map<String, dynamic>>> viewDiaryPages(
      {required String userId}) async {
    // get diary pages
    final pages = await _diaryService.getPages(userId: userId);
    // return as map
    return pages
        .map<Map<String, dynamic>>((page) => {
              'id': page.id,
              'date': page.date,
            })
        .toList();
  }

  /// Update a diary page date.
  Future<Map<String, dynamic>> updateDiaryPageDate({
    required String userId,
    required String pageId,
    required DateTime date,
  }) async {
    // update diary page
    final page = await _diaryService.changePageDate(
      userId: userId,
      pageId: pageId,
      date: date,
    );
    // return as map
    return {
      'id': page.id,
      'date': page.date,
    };
  }

  /// Add a diary section.
  Future<Map<String, dynamic>> addDiarySection({
    required String userId,
    required String pageId,
  }) async {
    // update diary page
    var page = await _diaryService.addSection(userId: userId, pageId: pageId);
    // return as map
    return {
      'id': page.id,
      'date': page.date,
      'sections': page.sections
          ?.map((section) => {
                'title': section.title,
                'cells': section.cells
                    ?.map((cell) => {
                          'time': cell.time,
                          'text': cell.text,
                          'tags': cell.tags,
                        })
                    .toList(),
              })
          .toList(),
    };
  }

  /// Add a diary cell.
  Future<Map<String, dynamic>> addDiaryCell({
    required String userId,
    required String pageId,
    required int sectionIndex,
  }) async {
    // update diary page
    var page = await _diaryService.addCell(
      userId: userId,
      pageId: pageId,
      sectionIndex: sectionIndex,
    );
    // return as map
    return {
      'id': page.id,
      'date': page.date,
      'sections': page.sections
          ?.map((section) => {
                'title': section.title,
                'cells': section.cells
                    ?.map((cell) => {
                          'time': cell.time,
                          'text': cell.text,
                          'tags': cell.tags,
                        })
                    .toList(),
              })
          .toList(),
    };
  }

  /// Update a diary cell text.
  Future<Map<String, dynamic>> updateDiaryCellText({
    required String userId,
    required String pageId,
    required int sectionIndex,
    required int cellIndex,
    required String text,
  }) async {
    // update diary cell
    var cell = await _diaryService.changeText(
      userId: userId,
      pageId: pageId,
      sectionIndex: sectionIndex,
      cellIndex: cellIndex,
      text: text,
    );
    // return as map
    return {'text': cell.text};
  }

  /// Remove a diary section.
  Future<Map<String, dynamic>> removeDiarySection({
    required String userId,
    required String pageId,
    required int sectionIndex,
  }) async {
    // update diary page
    var page = await _diaryService.removeSection(
      userId: userId,
      pageId: pageId,
      sectionIndex: sectionIndex,
    );
    // return as map
    return {
      'id': page.id,
      'date': page.date,
      'sections': page.sections
          ?.map((section) => {
                'title': section.title,
                'cells': section.cells
                    ?.map((cell) => {
                          'time': cell.time,
                          'text': cell.text,
                          'tags': cell.tags,
                        })
                    .toList(),
              })
          .toList(),
    };
  }

  /// Remove a diary cell.
  Future<Map<String, dynamic>> removeDiaryCell({
    required String userId,
    required String pageId,
    required int sectionIndex,
    required int cellIndex,
  }) async {
    // update diary page
    var page = await _diaryService.removeCell(
      userId: userId,
      pageId: pageId,
      sectionIndex: sectionIndex,
      cellIndex: cellIndex,
    );
    // return as map
    return {
      'id': page.id,
      'date': page.date,
      'sections': page.sections
          ?.map((section) => {
                'title': section.title,
                'cells': section.cells
                    ?.map((cell) => {
                          'time': cell.time,
                          'text': cell.text,
                          'tags': cell.tags,
                        })
                    .toList(),
              })
          .toList(),
    };
  }
}
