import 'dart:core';

import 'package:cloud_firestore/cloud_firestore.dart';

import '../../domain/models/diary_domain.dart';

/// Diary page firestore data model.
class DiaryPageFirestoreData {
  String? id;
  DateTime? date;
  List<DiarySectionFirestoreData>? sections;
  List<String>? actions;
  bool? isActive;
  DateTime? createdAt;
  DateTime? updatedAt;
  DateTime? deletedAt;

  DiaryPageFirestoreData({
    this.id,
    this.date,
    this.sections,
    this.actions,
    this.isActive,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
  });

  /// Convert [DiaryPageDomain] into [DiaryPageFirestoreData] object.
  factory DiaryPageFirestoreData.fromDomain(DiaryPageDomain model) =>
      DiaryPageFirestoreData(
        id: model.id,
        date: model.date,
        sections: model.sections
            ?.map((section) => DiarySectionFirestoreData.fromDomain(section))
            .toList(),
        actions: model.actions,
        isActive: model.isActive,
        createdAt: model.createdAt,
        updatedAt: model.updatedAt,
        deletedAt: model.deletedAt,
      );

  /// Convert firestore snapshot into [DiaryPageFirestoreData] object.
  factory DiaryPageFirestoreData.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot, {
    SnapshotOptions? options,
  }) {
    final data = snapshot.data();
    final page = DiaryPageFirestoreData.fromMap(data);
    page.id = snapshot.id;
    return page;
  }

  /// Convert [Map] into [DiaryPageFirestoreData] object.
  factory DiaryPageFirestoreData.fromMap(Map<String, dynamic>? map) =>
      DiaryPageFirestoreData(
        date: map?['date']?.toDate(),
        sections: map?['sections']
            ?.map<DiarySectionFirestoreData>(
                (section) => DiarySectionFirestoreData.fromMap(section))
            .toList(),
        actions: List<String>.from(map?['actions'] ?? []),
        isActive: map?['is_active'],
        createdAt: map?['created_at']?.toDate(),
        updatedAt: map?['updated_at']?.toDate(),
        deletedAt: map?['deleted_at']?.toDate(),
      );

  /// Convert [DiaryPageFirestoreData] into firestore json.
  Map<String, dynamic> toFirestore() => {
        if (date != null) 'date': date,
        if (sections != null)
          'sections':
              sections?.map((section) => section.toFirestore()).toList(),
        if (actions != null) 'actions': actions,
        if (isActive != null) 'is_active': isActive,
        if (createdAt != null) 'created_at': createdAt,
        if (updatedAt != null) 'updated_at': updatedAt,
        if (deletedAt != null) 'deleted_at': deletedAt,
      };
}

/// Diary section firestore data model.
class DiarySectionFirestoreData {
  String? title;
  List<String?>? cells;

  DiarySectionFirestoreData({
    this.title,
    this.cells,
  });

  /// Convert [DiarySectionDomain] into [DiarySectionFirestoreData] object.
  factory DiarySectionFirestoreData.fromDomain(DiarySectionDomain model) =>
      DiarySectionFirestoreData(
        title: model.title,
        cells: model.cells?.map((cell) => cell.id).toList(),
      );

  /// Convert [Map] into [DiarySectionFirestoreData] object.
  factory DiarySectionFirestoreData.fromMap(Map<String, dynamic>? map) =>
      DiarySectionFirestoreData(
        title: map?['title']?.toString(),
        cells: List<String>.from(map?['cells'] ?? []),
      );

  /// Convert [DiarySectionFirestoreData] into firestore json.
  Map<String, dynamic> toFirestore() => {
        if (title != null) 'title': title,
        if (cells != null) 'cells': cells,
      };
}

/// Diary cell firestore data model.
class DiaryCellFirestoreData {
  String? id;
  DateTime? time;
  String? text;
  String? image;
  List<String>? tags;
  bool? isActive;
  String? createdBy;

  DiaryCellFirestoreData({
    this.id,
    this.time,
    this.text,
    this.image,
    this.tags,
    this.isActive,
    this.createdBy,
  });

  /// Convert [DiaryCellDomain] into [DiaryCellFirestoreData] object.
  factory DiaryCellFirestoreData.fromDomain(DiaryCellDomain model) =>
      DiaryCellFirestoreData(
        id: model.id,
        time: model.time,
        text: model.text,
        image: model.image,
        tags: model.tags,
        isActive: model.isActive,
        createdBy: model.createdBy,
      );

  /// Convert firestore snapshot into [DiaryCellFirestoreData] object.
  factory DiaryCellFirestoreData.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot, {
    SnapshotOptions? options,
  }) {
    final data = snapshot.data();
    final cell = DiaryCellFirestoreData.fromMap(data);
    cell.id = snapshot.id;
    return cell;
  }

  /// Convert [Map] into [DiaryCellFirestoreData] object.
  factory DiaryCellFirestoreData.fromMap(Map<String, dynamic>? map) =>
      DiaryCellFirestoreData(
        time: map?['time']?.toDate(),
        text: map?['text']?.toString(),
        image: map?['image']?.toString(),
        tags: map?['tags']?.toList(),
        isActive: map?['is_active'],
        createdBy: map?['created_by']?.toString(),
      );

  /// Convert [DiaryCellFirestoreData] into firestore json.
  Map<String, dynamic> toFirestore() => {
        if (time != null) 'time': time,
        if (text != null) 'text': text,
        if (image != null) 'image': image,
        if (tags != null) 'tags': tags,
        if (isActive != null) 'is_active': isActive,
        if (createdBy != null) 'created_by': createdBy,
      };
}
