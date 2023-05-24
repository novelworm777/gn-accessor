import '../models/diary_domain.dart';
import '../services/diary_service.dart';

/// Usecase for diary module.
class DiaryUsecase {
  final DiaryService _diaryService = DiaryService();

  /// Get all diary pages for user diary.
  Future<List<Map<String, dynamic>>> viewDiaryPages(
      {required String userId}) async {
    List<DiaryPageDomain> pages = await _diaryService.getPages(userId: userId);
    return pages
        .map<Map<String, dynamic>>((page) => {
              'id': page.id,
              'date': page.date,
            })
        .toList();
  }
}
