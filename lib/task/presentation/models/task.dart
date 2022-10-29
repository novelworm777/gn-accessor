class Task {
  String? _id;
  String? _title;
  String? _notes;
  DateTime? _due;
  int? _available;
  int? _completed;
  int? _reward;

  String get id => _id!;
  String get title => _title!;
  String get notes => _notes!;
  DateTime get due => _due!;
  int get available => _available!;
  int get completed => _completed!;
  int get reward => _reward!;
}
