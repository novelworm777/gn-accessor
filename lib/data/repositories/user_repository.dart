import 'package:cloud_firestore/cloud_firestore.dart';

import '../../domain/models/user_domain.dart';
import '../../utils/services/firestore.dart';
import '../models/user_firestore_data.dart';

/// Repository for user [FirebaseFirestore] collection.
class UserRepository {
  final _firestore = Firestore.user();

  /// Find all user data.
  Future<List<UserDomain>> findAllWhereEqualTo({
    required String field,
    required dynamic value,
  }) async {
    final QuerySnapshot<UserFirestoreData> found =
        await _users().where(field, isEqualTo: value).get();
    return found.docs
        .map<UserDomain>((snapshot) => UserDomain.fromData(snapshot.data()))
        .toList();
  }

  /// Find a user data
  Future<UserDomain?> findOne({required String userId}) async {
    final UserFirestoreData? found = await _users().doc(userId).get().then(
          (snapshot) => snapshot.data(),
          onError: (error) => null,
        );
    if (found != null) return UserDomain.fromData(found);
    return null;
  }

  /// Update a user data.
  ///
  /// Only the data given will be updated, others will be untouched.
  Future<UserDomain?> updateOne({
    required String userId,
    required UserDomain data,
  }) async {
    await _users()
        .doc(userId)
        .set(UserFirestoreData.fromDomain(data), SetOptions(merge: true));
    return findOne(userId: userId);
  }

  /// Create [FirebaseFirestore] instance for user collection.
  CollectionReference<UserFirestoreData> _users() =>
      _firestore.withConverter<UserFirestoreData>(
        fromFirestore: (snapshot, _) =>
            UserFirestoreData.fromFirestore(snapshot),
        toFirestore: (model, _) => model.toFirestore(),
      );
}
