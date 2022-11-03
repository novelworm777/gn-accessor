import '../models/user.dart';
import '../services/user_service.dart';

/// Usecase for user module.
class UserUsecase {
  final UserService userService = UserService();

  /// authentication
  Future<Map<String, dynamic>> login({required String uid}) async {
    User? user = await userService.findByUID(uid: uid);
    if (user == null) {
      throw FormatException("unable to find user with uid: $uid");
    }
    return {'id': user.id};
  }
}
