import '../../data/models/user_firestore_data.dart';

/// User domain model.
class UserDomain {
  String? id;
  String? uid;
  String? name;
  int? cryois;
  DateTime? joinedAt;

  UserDomain({
    this.id,
    this.uid,
    this.name,
    this.cryois,
    this.joinedAt,
  });

  /// Convert [UserFirestoreData] into [UserDomain] object.
  factory UserDomain.fromData(UserFirestoreData model) => UserDomain(
        id: model.id,
        uid: model.uid,
        name: model.name,
        cryois: model.cryois,
        joinedAt: model.joinedAt,
      );
}
