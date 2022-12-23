import '../../data/repositories/user_repository.dart';
import '../models/user_domain.dart';

/// Service for user module.
class UserService {
  final UserRepository _repository = UserRepository();

  /// Find a user by [id].
  Future<UserDomain?> findById({required String id}) async {
    return await _repository.findOne(userId: id);
  }

  /// Find a user by [uid].
  Future<UserDomain?> findByUID({required String uid}) async {
    List<UserDomain?> users = await _repository.findAllWhereEqualTo(
      field: 'uid',
      value: uid,
    );
    if (users.isEmpty) return null;
    return users.first;
  }

  /// A new user just join the app.
  Future<UserDomain?> join({required UserDomain user}) async {
    // set join as today
    user.joinedAt = DateTime.now();
    // update user data
    return await _repository.updateOne(userId: user.id!, data: user);
  }

  /// Add the number of [cryois].
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
