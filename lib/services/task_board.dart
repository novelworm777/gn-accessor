import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gn_accessor/models/task.dart';
import 'package:gn_accessor/services/user.dart';
import 'package:gn_accessor/utils/map_utils.dart';

class TaskBoard {
  static const String collectionName = 'tasks';

  final CollectionReference<Map<String, dynamic>> _db =
      FirebaseFirestore.instance.collection(User.collectionName);

  Stream<QuerySnapshot<Map<String, dynamic>>> getTasks(String uid) {
    return _db
        .doc(uid)
        .collection(collectionName)
        .orderBy('created_at', descending: false)
        .snapshots();
  }

  /// Create a new task.
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
    if (raw['avail'] == null || raw['avail'] == 1) {
      task['available'] = 1;
    } else {
      task['available'] = int.parse(task['available']);
    }
    task['completed'] = 0;
    task['reward'] = raw['reward'] != null && raw['reward'] != ''
        ? int.parse(raw['reward'])
        : 0;
    task['created_at'] = DateTime.now();

    // create new document
    return await _db.doc(uid).collection(collectionName).add(task);
  }

  /// Completes a task.
  void completeTask(String uid, String id, Task task) {
    // delete task if it is no longer available
    if (task.completed! + 1 == task.available) {
      deleteTask(uid, id);
      return;
    }

    // update only completed field
    Map<String, dynamic> update = {'completed': task.completed! + 1};
    _db.doc(uid).collection(collectionName).doc(id).update(update);
  }

  /// Delete a task by ID.
  void deleteTask(String uid, String id) {
    _db.doc(uid).collection(collectionName).doc(id).delete();
  }
}
