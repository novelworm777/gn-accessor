import '../../data/models/diary_firestore_data.dart';

/// Diary page domain model.
class DiaryPageDomain {
  String? id;
  DateTime? date;
  List<DiarySectionDomain>? sections = [];
  List<String>? actions = [];
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
  factory DiaryPageDomain.fromData(
      DiaryPageFirestoreData model, List<DiaryCellDomain> cells) {
    // create cell dictionary
    Map<String, DiaryCellDomain> cellDict = {};
    for (DiaryCellDomain cell in cells) {
      cellDict[cell.id!] = cell;
    }
    // return converted diary page
    return DiaryPageDomain(
      id: model.id,
      date: model.date,
      sections: model.sections
              ?.map<DiarySectionDomain>(
                  (section) => DiarySectionDomain.fromData(section, cellDict))
              .toList() ??
          [],
      actions: model.actions ?? [],
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
  List<DiaryCellDomain>? cells = [];

  DiarySectionDomain({
    this.title,
    this.cells,
  });

  /// Convert [DiarySectionFirestoreData] into [DiarySectionDomain] object.
  factory DiarySectionDomain.fromData(DiarySectionFirestoreData model,
          Map<String, DiaryCellDomain> cellDict) =>
      DiarySectionDomain(
        title: model.title,
        cells: model.cells
                ?.map<DiaryCellDomain>((cell) => cellDict[cell]!)
                .toList() ??
            [],
      );
}

/// Diary cell domain model.
class DiaryCellDomain {
  String? id;
  DateTime? time;
  String? text;
  String? image;
  List<String>? tags = [];
  bool? isActive;
  String? createdBy;

  DiaryCellDomain({
    this.id,
    this.time,
    this.text,
    this.image,
    this.tags,
    this.isActive,
    this.createdBy,
  });

  /// Convert [DiaryCellFirestoreData] into [DiaryCellDomain] object.
  factory DiaryCellDomain.fromData(DiaryCellFirestoreData model) =>
      DiaryCellDomain(
        id: model.id,
        time: model.time,
        text: model.text,
        image: model.image,
        tags: model.tags ?? [],
        isActive: model.isActive,
        createdBy: model.createdBy,
      );
}
