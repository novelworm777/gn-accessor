import '../models/user_domain.dart';
import '../services/user_service.dart';

/// Usecase for user module.
class UserUsecase {
  final UserService _userService = UserService();

  Future<Map<String, dynamic>> inviteNewUser({required String uid}) async {
    // check whether the uid has already existed
    bool exist = await _userService.checkByUID(uid: uid);
    if (exist) {
      throw FormatException("UID $uid has already existed");
    }
    // create the new user
    await _userService.createNewUser(uid: uid);
    return {};
  }

  /// Authentication.
  Future<Map<String, dynamic>> login({required String uid}) async {
    UserDomain? user = await _userService.findByUID(uid: uid);
    if (user == null) {
      throw FormatException("unable to find user with uid: $uid");
    }
    if (user.joinedAt == null) _userService.join(user: user);
    return {'id': user.id};
  }
}
