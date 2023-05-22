import 'package:cloud_firestore/cloud_firestore.dart';

import '../../domain/models/invitation_code_domain.dart';

/// Invitation firestore data model.
class InvitationCodeFirestoreData {
  String? id;
  String? code;
  String? status;
  DateTime? createdAt;
  DateTime? usedAt;
  String? usedBy;

  InvitationCodeFirestoreData({
    this.id,
    this.code,
    this.status,
    this.createdAt,
    this.usedAt,
    this.usedBy,
  });

  /// Convert [InvitationCodeDomain] into [InvitationCodeFirestoreData] object.
  factory InvitationCodeFirestoreData.fromDomain(InvitationCodeDomain model) =>
      InvitationCodeFirestoreData(
        id: model.id,
        code: model.code,
        status: model.status,
        createdAt: model.createdAt,
        usedAt: model.usedAt,
        usedBy: model.usedBy,
      );

  /// Convert firestore snapshot into [InvitationCodeFirestoreData] object.
  factory InvitationCodeFirestoreData.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot, {
    SnapshotOptions? options,
  }) {
    final data = snapshot.data();
    final invitationCode = InvitationCodeFirestoreData.fromMap(data);
    invitationCode.id = snapshot.id;
    return invitationCode;
  }

  /// Convert [Map] into [InvitationCodeFirestoreData] object.
  factory InvitationCodeFirestoreData.fromMap(Map<String, dynamic>? map) =>
      InvitationCodeFirestoreData(
        code: map?['code']?.toString(),
        status: map?['status']?.toString(),
        createdAt: map?['created_at']?.toDate(),
        usedAt: map?['used_at']?.toDate(),
        usedBy: map?['used_by']?.toString(),
      );

  /// Convert [InvitationCodeFirestoreData] into firestore json.
  Map<String, dynamic> toFirestore() => {
        if (code != null) 'code': code,
        if (status != null) 'status': status,
        if (createdAt != null) 'created_at': createdAt,
        if (usedAt != null) 'used_at': usedAt,
        if (usedBy != null) 'used_by': usedBy,
      };
}
