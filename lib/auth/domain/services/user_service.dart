import '../../data/user_repository.dart';
import '../models/user.dart';

class UserService {
  final UserRepository _repository = UserRepository();

  Future<User?> findUserById(String id, bool throwError) async {
    User? found = await _repository.findUser(id);
    if (found == null && throwError) {
      throw const FormatException("user can't be found");
    }
    return found;
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
