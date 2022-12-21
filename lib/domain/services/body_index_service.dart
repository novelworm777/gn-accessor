import '../../data/repositories/body_index_repository.dart';
import '../../types/variant_doc.dart';
import '../models/body_index_domain.dart';

/// Service for body index module.
class BodyIndexService {
  final BodyIndexRepository _repository = BodyIndexRepository();

  /// Create a body index by [BodyIndexDomain.date].
  Future<BodyIndexDomain> createByDate({
    required String userId,
    required DateTime date,
    required Map<String, dynamic> data,
    bool create = true,
  }) async {
    BodyIndexDomain newBodyIndex = BodyIndexDomain.fromMap(data);
    newBodyIndex.date = date;
    return _repository.createOne(userId: userId, data: newBodyIndex);
  }

  /// Find a body index by [BodyIndexDomain.date].
  Future<BodyIndexDomain?> findByDate({
    required String userId,
    required DateTime date,
  }) async {
    return await _repository.findOneByDate(
      userId: userId,
      date: date,
    );
  }

  /// Find a variant data named locked.
  Future<BodyIndexDomain> findLocked({required String userId}) async {
    return await _repository.findVariant(
      userId: userId,
      variant: VariantDoc.locked,
    );
  }

  /// Change value of locked variant data.
  Future<BodyIndexDomain> changeLockedValue({
    required String userId,
    required Map<String, dynamic> data,
    bool update = true,
  }) async {
    // convert value into its property type
    if (data.containsKey('gender')) data['gender'] = data['gender'] as String?;
    if (data.containsKey('age')) data['age'] = int.parse(data['age']);
    if (data.containsKey('height')) data['height'] = int.parse(data['height']);
    // update locked data
    return await _repository.updateVariant(
      userId: userId,
      variant: VariantDoc.locked,
      data: data,
    );
  }

  /// Delete a body index by [BodyIndexDomain.id].
  void deleteById({
    required String userId,
    required String bodyIndexId,
  }) {
    _repository.deleteOneById(
      userId: userId,
      bodyIndexId: bodyIndexId,
    );
  }
}
