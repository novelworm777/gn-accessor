import 'package:cloud_firestore/cloud_firestore.dart';

class Task {
  String _id = '';
  String _title = '';
  String? _notes;
  DateTime? _dueDateTime;
  int? _available;
  int? _completed;
  int? _reward;

  Task.create(QueryDocumentSnapshot doc) {
    Map<dynamic, dynamic> data = doc.data() as Map;
    _id = doc.id;
    _title = data['title'] ?? '<< No Title >>';
    _notes = data['notes'];
    _dueDateTime = _timestampToDateTime(data['due_date_time']);
    _available = data['available'];
    _completed = data['completed'];
    _reward = data['reward'];
  }

  DateTime? _timestampToDateTime(Timestamp? time) => time?.toDate();

  String get id => _id;

  String get title => _title;

  String? get notes => _notes;

  DateTime? get dueDateTime => _dueDateTime;

  int? get completed => _completed;

  int? get available => _available;

  int? get reward => _reward;
}
