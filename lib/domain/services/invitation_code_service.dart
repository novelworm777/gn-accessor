import '../../data/repositories/invitation_code_repository.dart';
import '../models/invitation_code_domain.dart';

/// Service for invitation code module.
class InvitationCodeService {
  final InvitationCodeRepository _repository = InvitationCodeRepository();

  /// Find an invitation code by [InvitationCodeDomain.code].
  Future<InvitationCodeDomain?> findByCode({required String code}) async {
    List<InvitationCodeDomain?> invitationCodes =
        await _repository.findAllWhereEqualTo(
      field: 'code',
      value: code,
    );
    if (invitationCodes.isEmpty) return null;
    return invitationCodes.first;
  }

  /// Set an invitation code as used.
  Future<InvitationCodeDomain> usedByUser({
    required String id,
    required String userId,
  }) async {
    // set updated attributes
    InvitationCodeDomain updated = InvitationCodeDomain(
      status: InvitationCodeStatus.used,
      usedAt: DateTime.now().toUtc(),
      usedBy: userId,
    );
    // update data
    return await _repository.updateOne(invitationCodeId: id, data: updated);
  }
}
