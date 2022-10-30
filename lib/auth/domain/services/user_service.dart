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
}
