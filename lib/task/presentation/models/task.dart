import 'package:flutter/foundation.dart';

/// Task presentation model.
class Task with ChangeNotifier, DiagnosticableTreeMixin {
  String? _id;
  String? _title;
  String? _notes;
  DateTime? _due;
  int? _available;
  int? _completed;
  int? _reward;
  bool isViewed = false;

  /// No-args constructor for [Task].
  Task();

  /// Create [Task] from a map.
  Task.create(Map<String, dynamic> map) {
    _id = map['id'] ?? '-';
    _title = map['title'] ?? 'no title';
    _notes = map['notes'];
    _due = map['due'];
    _available = map['available'];
    _completed = map['completed'] ?? -1;
    _reward = map['completed'] ?? -1;
  }

  // getter
  String get id => _id!;
  String get title => _title!;
  String? get notes => _notes;
  DateTime? get due => _due;
  int? get available => _available;
  int get completed => _completed!;
  int get reward => _reward!;

  /// Complete a task.
  VoidCallback complete() {
    return () {
      _completed = _completed! + 1;
    };
  }

  /// Makes [Task] readable inside devtools.
  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(StringProperty('id', _id));
    properties.add(StringProperty('title', _title));
    properties.add(StringProperty('notes', _notes));
    properties.add(DiagnosticsProperty<DateTime>('due', _due));
    properties.add(IntProperty('available', _available));
    properties.add(IntProperty('completed', _completed));
    properties.add(IntProperty('reward', _reward));
  }
}
