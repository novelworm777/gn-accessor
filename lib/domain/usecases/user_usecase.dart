import '../models/user_domain.dart';
import '../services/user_service.dart';

/// Usecase for user module.
class UserUsecase {
  final UserService _userService = UserService();

  /// authentication
  Future<Map<String, dynamic>> login({required String uid}) async {
    UserDomain? user = await _userService.findByUID(uid: uid);
    if (user == null) {
      throw FormatException("unable to find user with uid: $uid");
    }
    if (user.joinedAt == null) _userService.join(user: user);
    return {'id': user.id};
  }
}
