import '../../constants/log_constants.dart';
import '../../data/repositories/log_repository.dart';
import '../models/log_domain.dart';

/// Service for log module.
class LogService {
  final LogRepository _repository = LogRepository();

  /// Create a new log.
  Future<LogDomain> createNewLog({
    required String userId,
    required String source,
    required String actionType,
    String? description,
  }) async {
    // set attributes
    LogDomain newLog = LogDomain(
      time: DateTime.now().toUtc(),
      source: source,
      actionType: actionType,
    );
    if (description != null) {
      newLog.description = description;
    }
    // create data
    return _repository.createOne(
      userId: userId,
      data: newLog,
    );
  }

  /// Create a log for when using invitation code.
  Future<LogDomain> useInvitationCode({
    required String userId,
    required String code,
  }) async {
    String description = "User $userId uses invitation code $code.";
    return createNewLog(
      userId: userId,
      source: LogSource.invitationCode,
      actionType: LogAction.use,
      description: description,
    );
  }
}
