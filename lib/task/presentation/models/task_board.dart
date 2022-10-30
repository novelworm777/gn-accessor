import 'package:flutter/foundation.dart';

import '../../domain/models/task.dart';

/// Task board presentation model.
class TaskBoard with ChangeNotifier, DiagnosticableTreeMixin {
  List<Task> _tasks = [];

  /// No-args constructor for [TaskBoard].
  TaskBoard();

  /// Makes [TaskBoard] readable inside devtools.
  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(IterableProperty('tasks', _tasks));
  }
}
