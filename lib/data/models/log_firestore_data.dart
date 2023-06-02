import 'package:cloud_firestore/cloud_firestore.dart';

import '../../domain/models/log_domain.dart';

/// Log firestore data model.
class LogFirestoreData {
  String? id;
  DateTime? time;
  String? source;
  String? actionType;
  String? description;

  LogFirestoreData({
    this.id,
    this.time,
    this.source,
    this.actionType,
    this.description,
  });

  /// Convert [LogDomain] into [LogFirestoreData] object.
  factory LogFirestoreData.fromDomain(LogDomain model) => LogFirestoreData(
        id: model.id,
        time: model.time,
        source: model.source,
        actionType: model.actionType,
        description: model.description,
      );

  /// Convert firestore snapshot into [LogFirestoreData] object.
  factory LogFirestoreData.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot, {
    SnapshotOptions? options,
  }) {
    final data = snapshot.data();
    final log = LogFirestoreData.fromMap(data);
    log.id = snapshot.id;
    return log;
  }

  /// Convert [Map] into [LogFirestoreData] object.
  factory LogFirestoreData.fromMap(Map<String, dynamic>? map) =>
      LogFirestoreData(
        time: map?['time']?.toDate(),
        source: map?['source']?.toString(),
        actionType: map?['action_type']?.toString(),
        description: map?['description']?.toString(),
      );

  /// Convert [LogFirestoreData] into firestore json.
  Map<String, dynamic> toFirestore() => {
        if (time != null) 'time': time,
        if (source != null) 'source': source,
        if (actionType != null) 'action_type': actionType,
        if (description != null) 'description': description,
      };
}
