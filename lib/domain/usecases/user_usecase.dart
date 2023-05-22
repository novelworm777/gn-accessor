import '../models/invitation_code_domain.dart';
import '../models/user_domain.dart';
import '../services/invitation_code_service.dart';
import '../services/log_service.dart';
import '../services/user_service.dart';

/// Usecase for user module.
class UserUsecase {
  final InvitationCodeService _invitationCodeService = InvitationCodeService();
  final LogService _logService = LogService();
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
      InvitationCodeDomain invitationCode =
          await validateInvitationCode(code: uid);
      user = await createNewUser(invitationCode: invitationCode);
    }
    return {'id': user.id};
  }

  /// Validate invitation code existence and usage.
  Future<InvitationCodeDomain> validateInvitationCode(
      {required String code}) async {
    InvitationCodeDomain? invitationCode =
        await _invitationCodeService.findByCode(code: code);
    if (invitationCode == null) {
      throw FormatException("unable to find invitation code with code: $code");
    }
    if (invitationCode.status == InvitationCodeStatus.used) {
      throw FormatException(
          "unable to use an already used invitation code with code : $code");
    }
    return invitationCode;
  }

  /// Create a new user with the invitation code.
  Future<UserDomain> createNewUser(
      {required InvitationCodeDomain invitationCode}) async {
    // create new user data
    UserDomain user =
        await _userService.createNewUser(uid: invitationCode.code!);
    // update invitation code data
    _invitationCodeService.usedByUser(
      id: invitationCode.id!,
      userId: user.id!,
    );
    // create new log
    _logService.useInvitationCode(
      userId: user.id!,
      code: invitationCode.code!,
    );
    return user;
  }
}
