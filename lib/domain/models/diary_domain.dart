import '../../data/models/diary_firestore_data.dart';

/// Diary page domain model.
class DiaryPageDomain {
  String? id;
  DateTime? date;
  List<DiarySectionDomain>? sections;
  List<String>? actions;
  bool? isActive;
  DateTime? createdAt;
  DateTime? updatedAt;
  DateTime? deletedAt;

  DiaryPageDomain({
    this.id,
    this.date,
    this.sections,
    this.actions,
    this.isActive,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
  });

  /// Convert [DiaryPageFirestoreData] into [DiaryPageDomain] object.
  factory DiaryPageDomain.fromData(DiaryPageFirestoreData model) {
    // convert diary sections
    List<DiarySectionDomain> convertedSections = [];
    if (model.sections != null) {
      for (final DiarySectionFirestoreData section in model.sections!) {
        convertedSections.add(DiarySectionDomain.fromData(section));
      }
    }
    // return converted diary page
    return DiaryPageDomain(
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
}

/// Diary section domain model.
class DiarySectionDomain {
  String? title;
  List<DiaryCellDomain>? cells;
  List<String>? tags;

  DiarySectionDomain({
    this.title,
    this.cells,
    this.tags,
  });

  /// Convert [DiarySectionFirestoreData] into [DiarySectionDomain] object.
  factory DiarySectionDomain.fromData(DiarySectionFirestoreData model) {
    // convert diary cells
    List<DiaryCellDomain> convertedCells = [];
    if (model.cells != null) {
      for (final DiaryCellFirestoreData cell in model.cells!) {
        convertedCells.add(DiaryCellDomain.fromData(cell));
      }
    }
    // return converted diary section
    return DiarySectionDomain(
      title: model.title,
      cells: convertedCells,
      tags: model.tags,
    );
  }
}

/// Diary cell domain model.
class DiaryCellDomain {
  DateTime? time;
  String? text;
  String? image;
  List<String>? tags;

  DiaryCellDomain({
    this.time,
    this.text,
    this.image,
    this.tags,
  });

  /// Convert [DiaryCellFirestoreData] into [DiaryCellDomain] object.
  factory DiaryCellDomain.fromData(DiaryCellFirestoreData model) =>
      DiaryCellDomain(
        time: model.time,
        text: model.text,
        image: model.image,
        tags: model.tags,
      );
}
