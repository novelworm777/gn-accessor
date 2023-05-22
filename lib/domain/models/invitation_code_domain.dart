import '../../data/models/invitation_code_firestore_data.dart';

/// Invitation code domain model.
class InvitationCodeDomain {
  String? id;
  String? code;
  String? status;
  DateTime? createdAt;
  DateTime? usedAt;
  String? usedBy;

  InvitationCodeDomain({
    this.id,
    this.code,
    this.status,
    this.createdAt,
    this.usedAt,
    this.usedBy,
  });

  /// Convert [InvitationCodeFirestoreData] into [InvitationCodeDomain] object.
  factory InvitationCodeDomain.fromData(InvitationCodeFirestoreData model) =>
      InvitationCodeDomain(
        id: model.id,
        code: model.code,
        status: model.status,
        createdAt: model.createdAt,
        usedAt: model.usedAt,
        usedBy: model.usedBy,
      );
}

/// Status of invitation code.
class InvitationCodeStatus {
  static const unused = 'UNUSED';
  static const used = 'USED';
}
