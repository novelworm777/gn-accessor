import 'package:cloud_firestore/cloud_firestore.dart';

import '../../domain/models/user_domain.dart';

/// User firestore data model.
class UserFirestoreData {
  String? id;
  String? uid;
  String? name;
  int? cryois;
  DateTime? joinedAt;

  UserFirestoreData({
    this.id,
    this.uid,
    this.name,
    this.cryois,
    this.joinedAt,
  });

  /// Convert [UserDomain] into [UserFirestoreData] object.
  factory UserFirestoreData.fromDomain(UserDomain model) => UserFirestoreData(
        id: model.id,
        uid: model.uid,
        name: model.name,
        cryois: model.cryois,
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
        uid: map?['uid']?.toString(),
        name: map?['name']?.toString(),
        cryois: int.tryParse(map?['cryois'] ?? ''),
        joinedAt: map?['joined_at']?.toDate(),
      );

  /// Convert [UserFirestoreData] into firestore json.
  Map<String, dynamic> toFirestore() => {
        if (uid != null) "uid": uid,
        if (name != null) "name": name,
        if (cryois != null) "cryois": cryois,
        if (joinedAt != null) "joined_at": joinedAt,
      };
}
