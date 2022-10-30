import 'package:gn_accessor/auth/domain/services/user_service.dart';

import '../models/user.dart';

class UserUsecase {
  final UserService userService = UserService();

  Future<Map<String, dynamic>> login(String? id) async {
    if (id == null) throw const FormatException('id is required');
    User? user = await userService.findUserById(id, true);
    return {
      'uid': user!.uid,
      'cryois': user.cryois,
    };
  }
}
