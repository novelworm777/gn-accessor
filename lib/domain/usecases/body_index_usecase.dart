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

  /// Get locked data of body index.
  Future<Map<String, dynamic>> viewLockedComponents({
    required String userId,
  }) async {
    BodyIndexDomain locked = await _bodyIndexService.findLocked(
      userId: userId,
    );
    return locked.getBasicProfileComponentsMap();
  }

  /// Change locked data value of body index.
  void lockComponent({
    required String userId,
    required Map<String, dynamic> data,
  }) async {
    await _bodyIndexService.changeLockedValue(userId: userId, data: data);
  }

  /// Delete a body index.
  void deleteBodyIndex({
    required String userId,
    required String bodyIndexId,
  }) {
    _bodyIndexService.deleteById(
      userId: userId,
      bodyIndexId: bodyIndexId,
    );
  }
}
