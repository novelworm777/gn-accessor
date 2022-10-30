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

  /// No-args constructor for [Task].
  Task();

  String get id => _id!;
  String get title => _title!;
  String get notes => _notes!;
  DateTime get due => _due!;
  int get available => _available!;
  int get completed => _completed!;
  int get reward => _reward!;

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
