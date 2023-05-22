import 'package:cloud_firestore/cloud_firestore.dart';

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
}
