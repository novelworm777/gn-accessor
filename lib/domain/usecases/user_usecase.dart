import 'package:gn_accessor/domain/services/user_service.dart';

import '../models/user.dart';

class UserUsecase {
  final UserService userService = UserService();

  Future<Map<String, dynamic>> login(String? id) async {
    if (id == null) throw const FormatException('id is required');
    User? user = await userService.findUserById(id);
    if (user == null) throw FormatException("unable to find user: $id");
    return {
      'uid': user.uid,
      'cryois': user.cryois,
    };
  }
}
