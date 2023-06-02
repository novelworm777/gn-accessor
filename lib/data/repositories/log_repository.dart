import 'package:cloud_firestore/cloud_firestore.dart';

import '../../constants/database_collection.dart';
import '../../domain/models/log_domain.dart';
import '../../utils/services/firestore.dart';
import '../models/log_firestore_data.dart';

/// Repository for log [FirebaseFirestore] collection.
class LogRepository {
  final _firestore = Firestore.user();

  /// Create [FirebaseFirestore] instance for log collection.
  CollectionReference<LogFirestoreData> _logs({required String userId}) =>
      _firestore.doc(userId).collection(dLog).withConverter<LogFirestoreData>(
            fromFirestore: (snapshot, _) =>
                LogFirestoreData.fromFirestore(snapshot),
            toFirestore: (model, _) => model.toFirestore(),
          );

  /// Create a log data.
  Future<LogDomain> createOne({
    required String userId,
    required LogDomain data,
  }) async {
    final converted = LogFirestoreData.fromDomain(data);
    final created = await _logs(userId: userId).add(converted).then(
          (snapshot) => snapshot.get(),
          onError: (error) =>
              throw FormatException("failed to create body index: $error"),
        );
    return LogDomain.fromData(created.data()!);
  }
}
