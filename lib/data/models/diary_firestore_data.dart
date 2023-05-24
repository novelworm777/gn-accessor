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
  factory DiaryPageFirestoreData.fromData(DiaryPageDomain model) {
    // convert diary sections
    List<DiarySectionFirestoreData> convertedSections = [];
    if (model.sections != null) {
      for (final DiarySectionDomain section in model.sections!) {
        convertedSections.add(DiarySectionFirestoreData.fromData(section));
      }
    }
    // return converted diary page
    return DiaryPageFirestoreData(
      id: model.id,
      date: model.date,
      sections: convertedSections,
      actions: model.actions,
      isActive: model.isActive,
      createdAt: model.createdAt,
      updatedAt: model.updatedAt,
      deletedAt: model.deletedAt,
    );
  }

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
  factory DiaryPageFirestoreData.fromMap(Map<String, dynamic>? map) {
    // convert diary sections
    List<DiarySectionFirestoreData> convertedSections = [];
    if (map?['sections'] != null) {
      for (final Map<String, dynamic> section in map?['sections']!) {
        convertedSections.add(DiarySectionFirestoreData.fromMap(section));
      }
    }
    // return converted page
    return DiaryPageFirestoreData(
      date: map?['date']?.toDate(),
      sections: convertedSections,
      actions: map?['actions']?.toList(),
      isActive: map?['is_active'],
      createdAt: map?['created_at']?.toDate(),
      updatedAt: map?['updated_at']?.toDate(),
      deletedAt: map?['deleted_at']?.toDate(),
    );
  }

  /// Convert [DiaryPageFirestoreData] into firestore json.
  Map<String, dynamic> toFirestore() {
    // convert diary sections
    List<Map> convertedSections = [];
    if (sections != null) {
      for (final DiarySectionFirestoreData section in sections!) {
        convertedSections.add(section.toFirestore());
      }
    }
    // return converted diary page
    return {
      if (date != null) 'date': date,
      if (sections != null) 'sections': convertedSections,
      if (actions != null) 'actions': actions,
      if (isActive != null) 'is_active': isActive,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (deletedAt != null) 'deleted_at': deletedAt,
    };
  }
}

/// Diary section firestore data model.
class DiarySectionFirestoreData {
  String? title;
  List<DiaryCellFirestoreData>? cells;
  List<String>? tags;

  DiarySectionFirestoreData({
    this.title,
    this.cells,
    this.tags,
  });

  /// Convert [DiarySectionDomain] into [DiarySectionFirestoreData] object.
  factory DiarySectionFirestoreData.fromData(DiarySectionDomain model) {
    // convert diary cells
    List<DiaryCellFirestoreData> convertedCells = [];
    if (model.cells != null) {
      for (final DiaryCellDomain cell in model.cells!) {
        convertedCells.add(DiaryCellFirestoreData.fromData(cell));
      }
    }
    // return converted diary section
    return DiarySectionFirestoreData(
      title: model.title,
      cells: convertedCells,
      tags: model.tags,
    );
  }

  /// Convert [Map] into [DiarySectionFirestoreData] object.
  factory DiarySectionFirestoreData.fromMap(Map<String, dynamic>? map) {
    // convert diary cells
    List<DiaryCellFirestoreData> convertedCells = [];
    if (map?['cells'] != null) {
      for (final Map<String, dynamic> cell in map?['cells']!) {
        convertedCells.add(DiaryCellFirestoreData.fromMap(cell));
      }
    }
    // return converted section
    return DiarySectionFirestoreData(
      title: map?['title']?.toString(),
      cells: convertedCells,
      tags: map?['tags']?.toList(),
    );
  }

  /// Convert [DiarySectionFirestoreData] into firestore json.
  Map<String, dynamic> toFirestore() {
    // convert diary cells
    List<Map> convertedCells = [];
    if (cells != null) {
      for (final DiaryCellFirestoreData cell in cells!) {
        convertedCells.add(cell.toFirestore());
      }
    }
    // return converted diary section
    return {
      if (title != null) 'title': title,
      if (cells != null) 'cells': convertedCells,
      if (tags != null) 'tags': tags,
    };
  }
}

/// Diary cell firestore data model.
class DiaryCellFirestoreData {
  DateTime? time;
  String? text;
  String? image;
  List<String>? tags;

  DiaryCellFirestoreData({
    this.time,
    this.text,
    this.image,
    this.tags,
  });

  /// Convert [DiaryCellDomain] into [DiaryCellFirestoreData] object.
  factory DiaryCellFirestoreData.fromData(DiaryCellDomain model) =>
      DiaryCellFirestoreData(
        time: model.time,
        text: model.text,
        image: model.image,
        tags: model.tags,
      );

  /// Convert [Map] into [DiaryCellFirestoreData] object.
  factory DiaryCellFirestoreData.fromMap(Map<String, dynamic>? map) =>
      DiaryCellFirestoreData(
        time: map?['time']?.toDate(),
        text: map?['text']?.toString(),
        image: map?['image']?.toString(),
        tags: map?['tags']?.toList(),
      );

  /// Convert [DiaryCellFirestoreData] into firestore json.
  Map<String, dynamic> toFirestore() => {
        if (time != null) 'time': time,
        if (text != null) 'text': text,
        if (image != null) 'image': image,
        if (tags != null) 'tags': tags,
      };
}
