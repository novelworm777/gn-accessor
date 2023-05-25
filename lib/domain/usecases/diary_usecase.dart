import '../models/diary_domain.dart';
import '../services/diary_service.dart';
import '../services/log_service.dart';

/// Usecase for diary module.
class DiaryUsecase {
  final DiaryService _diaryService = DiaryService();
  final LogService _logService = LogService();

  /// Create a diary page.
  Future<Map<String, dynamic>> createDiaryPage({required String userId}) async {
    // create new diary page
    DiaryPageDomain page = await _diaryService.create(userId: userId);
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
                'tags': section.tags,
              })
          .toList(),
    };
  }

  /// Get all diary pages for user diary.
  Future<List<Map<String, dynamic>>> viewDiaryPages(
      {required String userId}) async {
    // get diary pages
    List<DiaryPageDomain> pages = await _diaryService.getPages(userId: userId);
    // return as map
    return pages
        .map<Map<String, dynamic>>((page) => {
              'id': page.id,
              'date': page.date,
            })
        .toList();
  }
}
