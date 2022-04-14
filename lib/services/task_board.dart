import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gn_accessor/utils/map_utils.dart';

class TaskBoard {
  static const String _collectionName = 'tasks';

  final CollectionReference<Map<String, dynamic>> _db =
      FirebaseFirestore.instance.collection('users');

  Stream<QuerySnapshot<Map<String, dynamic>>> getTasks(String uid) {
    return _db
        .doc(uid)
        .collection(_collectionName)
        .orderBy('created_at', descending: false)
        .snapshots();
  }

  Future<DocumentReference<Map<String, dynamic>>> addTask(
      String uid, Map<String, dynamic> raw) async {
    // entries to be removed from raw data
    List<String> remove = ['due', 'avail'];
    if (raw['due'] != 2) remove.add('due_date_time');
    if (raw['avail'] != 2) {
      remove.add('available');
    }

    // clean raw data from null, empty string, and unnecessary entries
    final task = MapUtils.clean(raw, remove: remove);

    // add new entries according to raw data
    if (raw['avail'] == null || raw['avail'] == 1) task['available'] = 1;
    if (raw['avail'] != 3) task['completed'] = 0;
    task['reward'] = raw['reward'] != '' ? int.parse(raw['reward']) : 0;
    task['created_at'] = DateTime.now();

    // add to database
    return await _db.doc(uid).collection(_collectionName).add(task);
  }
}
