import '../../data/repositories/user_repository.dart';
import '../models/user_domain.dart';

/// Service for user module.
class UserService {
  final UserRepository _repository = UserRepository();

  /// Create a new user.
  Future<UserDomain> createNewUser({required String uid}) async {
    // set new user
    UserDomain newUser = UserDomain(
      uid: uid,
      joinedAt: DateTime.now(),
    );
    // create user in db
    return _repository.createOne(data: newUser);
  }

  /// Find a user by [UserDomain.id].
  Future<UserDomain?> findById({required String id}) async {
    return await _repository.findOne(userId: id);
  }

  /// Find a user by [UserDomain.uid].
  Future<UserDomain?> findByUID({required String uid}) async {
    List<UserDomain?> users = await _repository.findAllWhereEqualTo(
      field: 'uid',
      value: uid,
    );
    if (users.isEmpty) return null;
    return users.first;
  }

  /// Check the existence of a user by [UserDomain.uid].
  Future<bool> checkByUID({required String uid}) async {
    UserDomain? found = await findByUID(uid: uid);
    if (found != null) return true;
    return false;
  }

  /// Add the number of [UserDomain.cryois].
  UserDomain addCryois({
    required UserDomain user,
    required int number,
    bool update = true,
  }) {
    // update user
    UserDomain updated = UserDomain(cryois: (user.cryois ?? 0) + number);
    // update user data
    if (update) {
      _repository.updateOne(userId: user.id!, data: updated);
    }
    return user;
  }
}
