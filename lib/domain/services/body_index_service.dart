import '../../data/repositories/body_index_repository.dart';
import '../../types/variant_doc.dart';
import '../models/body_index_domain.dart';

/// Service for body index module.
class BodyIndexService {
  final BodyIndexRepository _repository = BodyIndexRepository();

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
