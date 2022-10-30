import 'package:flutter/foundation.dart';

import 'task.dart';

/// Task board presentation model.
class TaskBoard with ChangeNotifier, DiagnosticableTreeMixin {
  List<Task> _tasks = [];
  bool isViewed = false;

  /// No-args constructor for [TaskBoard].
  TaskBoard();

  /// Set [tasks] from a map iterable.
  set tasks(Iterable<Map<String, dynamic>> mapIterable) {
    _tasks = mapIterable.map<Task>((map) => Task.create(map)) as List<Task>;
  }

  /// Makes [TaskBoard] readable inside devtools.
  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(IterableProperty('tasks', _tasks));
  }
}
