import 'package:gn_accessor/domain/services/user_service.dart';

import '../models/user.dart';

class UserUsecase {
  final UserService userService = UserService();

  Future<Map<String, dynamic>> login({required String uid}) async {
    User? user = await userService.findByUID(uid: uid);
    if (user == null)
      throw FormatException("unable to find user with uid: $uid");
    return {
      'uid': user.uid,
      'cryois': user.cryois,
    };
  }
}
