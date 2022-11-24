import '../../data/user_repository.dart';
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
