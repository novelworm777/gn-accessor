import '../../data/models/invitation_code_firestore_data.dart';

/// Invitation code domain model.
class InvitationCodeDomain {
  String? id;
  String? code;
  DateTime? createdAt;
  DateTime? usedAt;
  String? usedBy;

  InvitationCodeDomain({
    this.id,
    this.code,
    this.createdAt,
    this.usedAt,
    this.usedBy,
  });

  /// Convert [InvitationCodeFirestoreData] into [InvitationCodeDomain] object.
  factory InvitationCodeDomain.fromData(InvitationCodeFirestoreData model) =>
      InvitationCodeDomain(
        id: model.id,
        code: model.code,
        createdAt: model.createdAt,
        usedAt: model.usedAt,
        usedBy: model.usedBy,
      );
}
