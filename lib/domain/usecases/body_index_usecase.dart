import '../models/body_index_domain.dart';
import '../services/body_index_service.dart';

/// Usecase for body index module.
class BodyIndexUseCase {
  final BodyIndexService _bodyIndexService = BodyIndexService();

  /// Get a body index.
  Future<Map<String, dynamic>> viewBodyIndex({
    required String userId,
    required DateTime date,
  }) async {
    BodyIndexDomain? bodyIndex = await _bodyIndexService.findByDate(
      userId: userId,
      date: date,
    );
    if (bodyIndex == null) {
      throw FormatException('unable to find body index by date: $date');
    }
    return {
      'id': bodyIndex.id,
      'date': bodyIndex.date,
      'basicProfile': bodyIndex.getBasicProfileComponentsMap(),
      'bodyIndex': bodyIndex.getBodyIndexComponentsMap(),
      'circumference': bodyIndex.getCircumferenceComponentsMap(),
    };
  }
}
