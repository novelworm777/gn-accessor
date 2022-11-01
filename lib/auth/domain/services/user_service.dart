import '../../data/user_repository.dart';
import '../models/user.dart';

class UserService {
  final UserRepository _repository = UserRepository();

  Future<User?> findUserById(String id) async {
    return await _repository.findUser(id);
  }

  /// Add the number of cryois.
  User addCryois({
    required User user,
    required int number,
    bool update = true,
  }) {
    user.cryois = user.cryois! + number;
    if (update) {
      Map<String, dynamic> updated = {'cryois': user.cryois};
      _repository.updateOne(userId: user.uid!, data: updated);
    }
    return user;
  }
}
