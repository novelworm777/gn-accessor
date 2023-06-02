import '../../data/models/log_firestore_data.dart';

/// Log domain model.
class LogDomain {
  String? id;
  DateTime? time;
  String? source;
  String? actionType;
  String? description;

  LogDomain({
    this.id,
    this.time,
    this.source,
    this.actionType,
    this.description,
  });

  /// Convert [LogFirestoreData] into [LogDomain] object.
  factory LogDomain.fromData(LogFirestoreData model) => LogDomain(
        id: model.id,
        time: model.time,
        source: model.source,
        actionType: model.actionType,
        description: model.description,
      );
}
