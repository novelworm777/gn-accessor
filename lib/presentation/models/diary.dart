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
