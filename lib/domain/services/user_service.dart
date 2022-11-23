import '../../data/repositories/user_repository.dart';
import '../models/user.dart';

/// Service for user module.
class UserService {
  final UserRepository _repository = UserRepository();

  /// Find a user by [id].
  Future<User?> findById({required String id}) async {
    return await _repository.findOne(userId: id);
  }

  /// Find a user by [uid].
  Future<User?> findByUID({required String uid}) async {
    List<User?> users = await _repository.findAllWhereEqualTo(
      field: 'uid',
      value: uid,
    );
    if (users.isEmpty) return null;
    return users.first;
  }

  /// Add the number of [cryois].
  User addCryois({
    required User user,
    required int number,
    bool update = true,
  }) {
    // update user
    user.cryois = (user.cryois ?? 0) + number;

    // update user data
    if (update) {
      Map<String, dynamic> updated = {'cryois': user.cryois};
      _repository.updateOne(userId: user.id, data: updated);
    }

    return user;
  }
}
