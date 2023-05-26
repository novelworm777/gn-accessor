/// Diary page dates presentation model.
class DiaryPageDate {
  final String id;
  final DateTime date;

  DiaryPageDate({
    required this.id,
    required this.date,
  });

  /// Convert [Map] into [DiaryPageDate] object.
  factory DiaryPageDate.fromMap(Map<String, dynamic> map) => DiaryPageDate(
        id: map['id'],
        date: map['date'],
      );
}

/// Diary page presentation model.
class DiaryPage {
  final String id;
  DateTime date;
  List<DiarySection> sections;

  DiaryPage({
    required this.id,
    required this.date,
    required this.sections,
  });

  /// Convert [Map] into [DiaryPage] object.
  factory DiaryPage.fromMap(Map<String, dynamic> map) => DiaryPage(
        id: map['id'],
        date: map['date'],
        sections: map['sections']
                .map<DiarySection>((section) => DiarySection.fromMap(section))
                .toList() ??
            [],
      );
}

/// Diary section presentation model.
class DiarySection {
  String? title;
  List<DiaryCell> cells;

  DiarySection({
    this.title,
    required this.cells,
  });

  /// Convert [Map] into [DiarySection] object.
  factory DiarySection.fromMap(Map<String, dynamic> map) => DiarySection(
        title: map['title'],
        cells: map['cells']
                .map<DiaryCell>((cell) => DiaryCell.fromMap(cell))
                .toList() ??
            [],
      );
}

/// Diary cell presentation model.
class DiaryCell {
  DateTime? time;
  String? text;
  List<String>? tags;

  DiaryCell({
    this.time,
    this.text,
    this.tags,
  });

  /// Convert [Map] into [DiaryCell] object.
  factory DiaryCell.fromMap(Map<String, dynamic> map) => DiaryCell(
        time: map['time'],
        text: map['text'],
        tags: map['tags'] ?? [],
      );
}
