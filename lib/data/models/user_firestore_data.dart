import 'package:cloud_firestore/cloud_firestore.dart';

import '../../domain/models/user_domain.dart';

/// User firestore data model.
class UserFirestoreData {
  String? id;
  String? uid;
  String? name;
  int? cryois;
  DateTime? invitedAt;
  DateTime? joinedAt;

  UserFirestoreData({
    this.id,
    this.uid,
    this.name,
    this.cryois,
    this.invitedAt,
    this.joinedAt,
  });

  /// Convert [UserDomain] into [UserFirestoreData] object.
  factory UserFirestoreData.fromDomain(UserDomain model) => UserFirestoreData(
        id: model.id,
        uid: model.uid,
        name: model.name,
        cryois: model.cryois,
        invitedAt: model.invitedAt,
        joinedAt: model.joinedAt,
      );

  /// Convert firestore snapshot into [UserFirestoreData] object.
  factory UserFirestoreData.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot, {
    SnapshotOptions? options,
  }) {
    final data = snapshot.data();
    final user = UserFirestoreData.fromMap(data);
    user.id = snapshot.id;
    return user;
  }

  /// Convert [Map] into [UserFirestoreData] object.
  factory UserFirestoreData.fromMap(Map<String, dynamic>? map) =>
      UserFirestoreData(
        uid: map?['uid'] as String?,
        name: map?['name'] as String?,
        cryois: map?['cryois'] as int?,
        invitedAt: map?['invitedAt']?.toDate(),
        joinedAt: map?['joinedAt']?.toDate(),
      );

  /// Convert [UserFirestoreData] into firestore json.
  Map<String, dynamic> toFirestore() => {
        if (uid != null) "uid": uid,
        if (name != null) "name": name,
        if (cryois != null) "cryois": cryois,
        if (invitedAt != null) "invitedAt": invitedAt,
        if (joinedAt != null) "joinedAt": joinedAt,
      };
}
