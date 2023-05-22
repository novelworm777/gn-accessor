import 'package:cloud_firestore/cloud_firestore.dart';

import '../../domain/models/invitation_code_domain.dart';
import '../../utils/services/firestore.dart';
import '../models/invitation_code_firestore_data.dart';

/// Repository for invitation code [FirebaseFirestore] collection.
class InvitationCodeRepository {
  final _firestore = Firestore.invitationCode();

  /// Create [FirebaseFirestore] instance for invitation codes collection.
  CollectionReference<InvitationCodeFirestoreData> _invitationCodes() =>
      _firestore.withConverter<InvitationCodeFirestoreData>(
        fromFirestore: (snapshot, _) =>
            InvitationCodeFirestoreData.fromFirestore(snapshot),
        toFirestore: (model, _) => model.toFirestore(),
      );

  /// Find all invitation code data.
  Future<List<InvitationCodeDomain>> findAllWhereEqualTo({
    required String field,
    required dynamic value,
  }) async {
    final QuerySnapshot<InvitationCodeFirestoreData> found =
        await _invitationCodes().where(field, isEqualTo: value).get();
    return found.docs
        .map<InvitationCodeDomain>(
            (snapshot) => InvitationCodeDomain.fromData(snapshot.data()))
        .toList();
  }

  /// Find an invitation code data
  Future<InvitationCodeDomain?> findOne(
      {required String invitationCodeId}) async {
    final InvitationCodeFirestoreData? found =
        await _invitationCodes().doc(invitationCodeId).get().then(
              (snapshot) => snapshot.data(),
              onError: (error) => null,
            );
    if (found != null) return InvitationCodeDomain.fromData(found);
    return null;
  }

  /// Update an invitation code data.
  ///
  /// Only the data given will be updated, others will be untouched.
  Future<InvitationCodeDomain> updateOne({
    required String invitationCodeId,
    required InvitationCodeDomain data,
  }) async {
    await _invitationCodes().doc(invitationCodeId).set(
          InvitationCodeFirestoreData.fromDomain(data),
          SetOptions(merge: true),
        );
    final found = await findOne(invitationCodeId: invitationCodeId);
    return found!;
  }
}
